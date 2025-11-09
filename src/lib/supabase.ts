import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Helper function to get current tenant ID from user metadata
export const getCurrentTenantId = async () => {
  const { data: { user } } = await supabase.auth.getUser()
  return user?.user_metadata?.tenant_id || null
}

// Helper function to set tenant context for RLS
export const setTenantContext = async (tenantId: string) => {
  await supabase.rpc('set_tenant_context', { tenant_id: tenantId })
}

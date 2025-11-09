export interface Tenant {
  id: string
  name: string
  subdomain: string
  created_at: string
  subscription_status: 'trial' | 'active' | 'cancelled' | 'past_due'
  subscription_plan: 'starter' | 'professional' | 'enterprise'
}

export interface User {
  id: string
  email: string
  tenant_id: string
  role: 'admin' | 'recruiter' | 'viewer'
  first_name: string
  last_name: string
  avatar_url?: string
  created_at: string
}

export interface Driver {
  id: string
  tenant_id: string
  first_name: string
  last_name: string
  email: string
  phone: string
  cdl_number?: string
  cdl_state?: string
  status: string
  recruiter_id?: string
  created_at: string
  updated_at: string
}

export interface Job {
  id: string
  tenant_id: string
  title: string
  company_name: string
  location: string
  job_type: string
  pay_range: string
  description: string
  requirements: string
  status: 'active' | 'closed' | 'draft'
  created_by: string
  created_at: string
  updated_at: string
}

export interface Recruiter {
  id: string
  tenant_id: string
  user_id: string
  first_name: string
  last_name: string
  email: string
  phone: string
  status: 'active' | 'inactive'
  hire_date?: string
  created_at: string
}

export interface Carrier {
  id: string
  tenant_id: string
  name: string
  mc_number?: string
  dot_number?: string
  contact_name: string
  contact_email: string
  contact_phone: string
  address: string
  city: string
  state: string
  zip: string
  status: 'active' | 'inactive'
  created_at: string
}

export interface ChatMessage {
  id: string
  tenant_id: string
  conversation_id: string
  sender_id: string
  content: string
  created_at: string
  read: boolean
}

export interface Conversation {
  id: string
  tenant_id: string
  participants: string[]
  last_message?: string
  last_message_at?: string
  created_at: string
}

export interface Email {
  id: string
  tenant_id: string
  from: string
  to: string
  subject: string
  body: string
  sent_at: string
  read: boolean
}

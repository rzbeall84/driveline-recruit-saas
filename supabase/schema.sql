-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create tenants table
CREATE TABLE IF NOT EXISTS tenants (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  subdomain TEXT UNIQUE NOT NULL,
  subscription_status TEXT DEFAULT 'trial' CHECK (subscription_status IN ('trial', 'active', 'cancelled', 'past_due')),
  subscription_plan TEXT DEFAULT 'starter' CHECK (subscription_plan IN ('starter', 'professional', 'enterprise')),
  stripe_customer_id TEXT,
  stripe_subscription_id TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create users table
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  role TEXT DEFAULT 'recruiter' CHECK (role IN ('admin', 'recruiter', 'viewer')),
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create drivers table
CREATE TABLE IF NOT EXISTS drivers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  cdl_number TEXT,
  cdl_state TEXT,
  status TEXT DEFAULT 'new',
  recruiter_id UUID REFERENCES users(id) ON DELETE SET NULL,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create jobs table
CREATE TABLE IF NOT EXISTS jobs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  company_name TEXT NOT NULL,
  location TEXT NOT NULL,
  job_type TEXT NOT NULL,
  pay_range TEXT,
  description TEXT,
  requirements TEXT,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'closed', 'draft')),
  created_by UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create recruiters table
CREATE TABLE IF NOT EXISTS recruiters (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
  hire_date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create carriers table
CREATE TABLE IF NOT EXISTS carriers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  mc_number TEXT,
  dot_number TEXT,
  contact_name TEXT NOT NULL,
  contact_email TEXT NOT NULL,
  contact_phone TEXT,
  address TEXT,
  city TEXT,
  state TEXT,
  zip TEXT,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create conversations table
CREATE TABLE IF NOT EXISTS conversations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
  participants UUID[] NOT NULL,
  last_message TEXT,
  last_message_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create chat_messages table
CREATE TABLE IF NOT EXISTS chat_messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
  conversation_id UUID REFERENCES conversations(id) ON DELETE CASCADE,
  sender_id UUID REFERENCES users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create emails table
CREATE TABLE IF NOT EXISTS emails (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
  from_address TEXT NOT NULL,
  to_address TEXT NOT NULL,
  subject TEXT NOT NULL,
  body TEXT NOT NULL,
  sent_at TIMESTAMPTZ DEFAULT NOW(),
  read BOOLEAN DEFAULT FALSE
);

-- Enable Row Level Security
ALTER TABLE tenants ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE drivers ENABLE ROW LEVEL SECURITY;
ALTER TABLE jobs ENABLE ROW LEVEL SECURITY;
ALTER TABLE recruiters ENABLE ROW LEVEL SECURITY;
ALTER TABLE carriers ENABLE ROW LEVEL SECURITY;
ALTER TABLE conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE emails ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for multi-tenancy
-- Users can only see data from their own tenant

-- Tenants policies
CREATE POLICY "Users can view their own tenant"
  ON tenants FOR SELECT
  USING (id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

-- Users policies
CREATE POLICY "Users can view users in their tenant"
  ON users FOR SELECT
  USING (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

-- Drivers policies
CREATE POLICY "Users can view drivers in their tenant"
  ON drivers FOR SELECT
  USING (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

CREATE POLICY "Users can insert drivers in their tenant"
  ON drivers FOR INSERT
  WITH CHECK (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

CREATE POLICY "Users can update drivers in their tenant"
  ON drivers FOR UPDATE
  USING (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

-- Jobs policies
CREATE POLICY "Users can view jobs in their tenant"
  ON jobs FOR SELECT
  USING (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

CREATE POLICY "Users can insert jobs in their tenant"
  ON jobs FOR INSERT
  WITH CHECK (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

CREATE POLICY "Users can update jobs in their tenant"
  ON jobs FOR UPDATE
  USING (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

-- Recruiters policies
CREATE POLICY "Users can view recruiters in their tenant"
  ON recruiters FOR SELECT
  USING (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

-- Carriers policies
CREATE POLICY "Users can view carriers in their tenant"
  ON carriers FOR SELECT
  USING (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

CREATE POLICY "Users can insert carriers in their tenant"
  ON carriers FOR INSERT
  WITH CHECK (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

-- Chat policies
CREATE POLICY "Users can view conversations in their tenant"
  ON conversations FOR SELECT
  USING (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

CREATE POLICY "Users can view messages in their tenant"
  ON chat_messages FOR SELECT
  USING (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

-- Email policies
CREATE POLICY "Users can view emails in their tenant"
  ON emails FOR SELECT
  USING (tenant_id IN (
    SELECT tenant_id FROM users WHERE id = auth.uid()
  ));

-- Create indexes for better performance
CREATE INDEX idx_users_tenant_id ON users(tenant_id);
CREATE INDEX idx_drivers_tenant_id ON drivers(tenant_id);
CREATE INDEX idx_drivers_recruiter_id ON drivers(recruiter_id);
CREATE INDEX idx_jobs_tenant_id ON jobs(tenant_id);
CREATE INDEX idx_recruiters_tenant_id ON recruiters(tenant_id);
CREATE INDEX idx_carriers_tenant_id ON carriers(tenant_id);
CREATE INDEX idx_conversations_tenant_id ON conversations(tenant_id);
CREATE INDEX idx_chat_messages_tenant_id ON chat_messages(tenant_id);
CREATE INDEX idx_chat_messages_conversation_id ON chat_messages(conversation_id);
CREATE INDEX idx_emails_tenant_id ON emails(tenant_id);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Add updated_at triggers
CREATE TRIGGER update_tenants_updated_at BEFORE UPDATE ON tenants
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_drivers_updated_at BEFORE UPDATE ON drivers
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_jobs_updated_at BEFORE UPDATE ON jobs
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_recruiters_updated_at BEFORE UPDATE ON recruiters
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_carriers_updated_at BEFORE UPDATE ON carriers
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

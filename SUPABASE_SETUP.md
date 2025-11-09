# Supabase Setup Guide

Follow these steps to set up your Supabase database for DriveLine Recruit SaaS.

## Step 1: Create Supabase Project

1. Go to https://supabase.com/dashboard
2. Click **"New Project"**
3. Fill in the details:
   - **Name**: `driveline-recruit-saas`
   - **Database Password**: Choose a strong password (save this!)
   - **Region**: Choose closest to your users
4. Click **"Create new project"**
5. Wait for the project to be created (~2 minutes)

## Step 2: Run Database Schema

1. In your Supabase dashboard, click **"SQL Editor"** in the left sidebar
2. Click **"New query"**
3. Copy the entire contents of `supabase/schema.sql` from this repository
4. Paste it into the SQL editor
5. Click **"Run"** (or press Ctrl/Cmd + Enter)
6. You should see: **"Success. No rows returned"**

This creates:
- All database tables (tenants, users, drivers, jobs, recruiters, carriers, etc.)
- Row Level Security (RLS) policies for multi-tenancy
- Indexes for performance
- Triggers for updated_at timestamps

## Step 3: Insert Demo Data

1. In SQL Editor, click **"New query"** again
2. Copy the entire contents of `supabase/seed-demo-data.sql`
3. Paste it into the SQL editor
4. Click **"Run"**
5. You should see success messages

This inserts:
- 3 demo tenant companies
- 6 admin/recruiter users
- 7 recruiters with profiles
- 10 carriers with full details
- 33 realistic drivers
- 12 job postings

## Step 4: Verify Data

1. Click **"Table Editor"** in the left sidebar
2. Check each table to see the data:
   - Click **"tenants"** - should see 3 companies
   - Click **"drivers"** - should see 33 drivers
   - Click **"jobs"** - should see 12 jobs
   - Click **"recruiters"** - should see 7 recruiters
   - Click **"carriers"** - should see 10 carriers

## Step 5: Get Your API Credentials

1. Click **"Project Settings"** (gear icon in left sidebar)
2. Click **"API"** in the settings menu
3. Copy these values (you'll need them for deployment):

   **Project URL:**
   ```
   https://[your-project-ref].supabase.co
   ```
   
   **anon/public key:**
   ```
   eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   ```

## Step 6: Configure Authentication

1. Click **"Authentication"** in the left sidebar
2. Click **"Providers"**
3. Make sure **"Email"** is enabled (it should be by default)
4. Optional: Configure email templates under **"Email Templates"**

### Email Configuration (Optional but Recommended)

1. Go to **"Project Settings"** → **"Auth"**
2. Scroll to **"SMTP Settings"**
3. Configure your email provider (or use Supabase's default for testing)

## Step 7: Test Database Connection

You can test the connection using the Supabase client:

```javascript
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  'YOUR_SUPABASE_URL',
  'YOUR_SUPABASE_ANON_KEY'
)

// Test query
const { data, error } = await supabase
  .from('drivers')
  .select('*')
  .limit(5)

console.log(data) // Should show 5 drivers
```

## Step 8: Set Up Row Level Security (Already Done!)

The schema.sql file already set up RLS policies, but here's what it does:

- **Multi-tenancy**: Users can only see data from their own tenant
- **Security**: All tables are protected with RLS
- **Automatic**: tenant_id is automatically filtered in all queries

## Troubleshooting

### Error: "relation already exists"
- You've already run the schema. That's okay! Skip to step 3.

### Error: "permission denied"
- Make sure you're using the SQL Editor as the project owner
- Check that you're logged into the correct Supabase account

### No data showing in tables
- Make sure you ran the seed-demo-data.sql file
- Check for errors in the SQL Editor output
- Verify the queries completed successfully

### RLS blocking queries
- This is expected! RLS policies require authentication
- Users must be logged in to see data
- Each user only sees data from their tenant

## Next Steps

After completing this setup:

1. ✅ Database is ready
2. ✅ Demo data is loaded
3. ✅ RLS is configured
4. → Copy your API credentials
5. → Proceed to Vercel deployment (see DEPLOYMENT.md)

## Important Notes

- **Save your database password** - you'll need it for migrations
- **Save your API keys** - you'll need them for deployment
- **Don't share your service_role key** - it bypasses RLS (keep it secret!)
- The **anon key is safe to use** in your frontend code

## Demo Tenant Information

After setup, you have these demo tenants:

1. **Acme Trucking Solutions**
   - Subdomain: `acme-trucking`
   - 15 drivers, 5 jobs, 4 recruiters

2. **Swift Transport Group**
   - Subdomain: `swift-transport`
   - 8 drivers, 4 jobs, 2 recruiters

3. **Roadway Logistics Inc**
   - Subdomain: `roadway-logistics`
   - 5 drivers, 3 jobs, 1 recruiter

You can sign up as a new user to create your own tenant, or create auth users that match the demo user IDs in the seed data.

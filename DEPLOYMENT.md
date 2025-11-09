# Deployment Guide

## Prerequisites

1. **Supabase Project**: Create a project at https://supabase.com
2. **Vercel Account**: Sign up at https://vercel.com
3. **Stripe Account**: Sign up at https://stripe.com (for billing features)

## Step 1: Set Up Supabase Database

1. Go to your Supabase project dashboard
2. Navigate to **SQL Editor**
3. Create a new query and paste the contents of `supabase/schema.sql`
4. Run the query to create all tables and RLS policies
5. Create another new query and paste the contents of `supabase/seed-demo-data.sql`
6. Run the query to insert demo data

### Get Your Supabase Credentials

1. Go to **Project Settings** → **API**
2. Copy your **Project URL** (this is your `VITE_SUPABASE_URL`)
3. Copy your **anon/public key** (this is your `VITE_SUPABASE_ANON_KEY`)

## Step 2: Deploy to Vercel

### Option A: Deploy via Vercel Dashboard (Recommended)

1. Go to https://vercel.com/new
2. Import your GitHub repository: `rzbeall84/driveline-recruit-saas`
3. Configure the project:
   - **Framework Preset**: Vite
   - **Build Command**: `pnpm build`
   - **Output Directory**: `dist`
4. Add Environment Variables:
   ```
   VITE_SUPABASE_URL=your_supabase_project_url
   VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
   VITE_STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
   ```
5. Click **Deploy**

### Option B: Deploy via CLI

1. Install Vercel CLI:
   ```bash
   pnpm add -g vercel
   ```

2. Login to Vercel:
   ```bash
   vercel login
   ```

3. Deploy:
   ```bash
   cd /path/to/driveline-recruit-saas
   vercel
   ```

4. Follow the prompts and add environment variables when asked

## Step 3: Configure Environment Variables

After deployment, you can manage environment variables in:
- Vercel Dashboard → Your Project → Settings → Environment Variables

Add these variables:
- `VITE_SUPABASE_URL`: Your Supabase project URL
- `VITE_SUPABASE_ANON_KEY`: Your Supabase anon key
- `VITE_STRIPE_PUBLISHABLE_KEY`: Your Stripe publishable key (optional for now)

## Step 4: Test the Deployment

1. Visit your Vercel URL (e.g., `https://driveline-recruit-saas.vercel.app`)
2. Try to sign up with a test account
3. Verify that demo data loads correctly
4. Test navigation between pages

## Step 5: Add Custom Domain (Optional)

1. Go to Vercel Dashboard → Your Project → Settings → Domains
2. Add your custom domain
3. Follow Vercel's instructions to configure DNS

## Demo Login Credentials

After running the seed data, you can create test accounts or use the demo tenant data:

**Demo Tenants:**
- Acme Trucking Solutions (subdomain: `acme-trucking`)
- Swift Transport Group (subdomain: `swift-transport`)
- Roadway Logistics Inc (subdomain: `roadway-logistics`)

**Note**: You'll need to create auth users in Supabase Auth that match the user IDs in the seed data, or simply sign up with new accounts.

## Troubleshooting

### Build Fails
- Check that all dependencies are installed
- Verify environment variables are set correctly
- Check build logs in Vercel dashboard

### Database Connection Issues
- Verify Supabase URL and anon key are correct
- Check that RLS policies are enabled
- Ensure schema was created successfully

### Authentication Issues
- Verify Supabase Auth is enabled
- Check that email confirmation is configured
- Review Supabase Auth logs

## Next Steps

1. **Configure Stripe**: Set up Stripe products and webhooks for subscription billing
2. **Email Setup**: Configure email templates in Supabase
3. **Custom Branding**: Update logos and colors in the codebase
4. **Add Custom Domain**: Point your domain to Vercel
5. **Enable Analytics**: Add Vercel Analytics or Google Analytics
6. **Set Up Monitoring**: Configure error tracking (e.g., Sentry)

## Support

For issues or questions:
- Check the main README.md
- Review Supabase documentation: https://supabase.com/docs
- Review Vercel documentation: https://vercel.com/docs

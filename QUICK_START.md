# Quick Start Guide

Get your DriveLine Recruit SaaS up and running in 15 minutes!

## Prerequisites
- GitHub account (you already have this!)
- Supabase account (free): https://supabase.com
- Vercel account (free): https://vercel.com

## Step-by-Step Setup

### 1. Set Up Supabase (5 minutes)

1. Go to https://supabase.com/dashboard
2. Create new project: `driveline-recruit-saas`
3. Wait for project creation
4. Go to **SQL Editor** → **New query**
5. Copy/paste contents of `supabase/schema.sql` → Run
6. **New query** again
7. Copy/paste contents of `supabase/seed-demo-data.sql` → Run
8. Go to **Project Settings** → **API**
9. Copy your **Project URL** and **anon key**

📝 **Save these credentials - you'll need them next!**

### 2. Deploy to Vercel (5 minutes)

1. Go to https://vercel.com/new
2. Click **"Import Git Repository"**
3. Select `rzbeall84/driveline-recruit-saas`
4. Click **"Import"**
5. Add environment variables:
   ```
   VITE_SUPABASE_URL = [your Supabase URL]
   VITE_SUPABASE_ANON_KEY = [your Supabase anon key]
   VITE_STRIPE_PUBLISHABLE_KEY = [leave blank for now]
   ```
6. Click **"Deploy"**
7. Wait 2-3 minutes for deployment

### 3. Test Your App (5 minutes)

1. Visit your Vercel URL: `https://driveline-recruit-saas.vercel.app`
2. Click **"Sign up"**
3. Create a test account:
   - Company Name: `Test Company`
   - Subdomain: `test-company`
   - Your name and email
   - Password
4. Check your email for verification link
5. Sign in and explore!

## What You'll See

After signing in, you'll have access to:

- **Dashboard** - Overview of your recruiting platform
- **Drivers** - 33 demo drivers with realistic data
- **Jobs** - 12 job postings
- **Recruiters** - 7 team members
- **Carriers** - 10 carrier companies
- **Chat** - Team communication (coming soon)
- **Email** - Email management (coming soon)

## Demo Data

The platform includes realistic demo data:
- 3 demo companies (tenants)
- 33 drivers with CDL info, contact details, and notes
- 12 job postings across different locations
- 7 recruiters with profiles
- 10 major carriers with full contact information

**All data is isolated by tenant** - each company only sees their own data!

## Next Steps

### Immediate
- [ ] Test all pages (Drivers, Jobs, Recruiters, Carriers)
- [ ] Verify demo data loads correctly
- [ ] Test sign up/sign in flow

### Soon
- [ ] Add your custom domain in Vercel
- [ ] Customize branding (logo, colors)
- [ ] Set up Stripe for billing
- [ ] Configure email templates
- [ ] Take screenshots for marketing

### Later
- [ ] Implement chat feature
- [ ] Add email integration
- [ ] Build out additional features from main app
- [ ] Launch to production!

## Troubleshooting

**Can't see demo data?**
- Make sure you ran both SQL files in Supabase
- Check Supabase Table Editor to verify data exists
- Try signing out and back in

**Build failed on Vercel?**
- Check environment variables are set correctly
- Verify Supabase URL doesn't have trailing slash
- Check Vercel build logs for specific errors

**Authentication not working?**
- Verify Supabase Auth is enabled
- Check email confirmation settings
- Look at Supabase Auth logs

## Local Development

Want to develop locally?

```bash
# Clone the repo
git clone https://github.com/rzbeall84/driveline-recruit-saas.git
cd driveline-recruit-saas

# Install dependencies
pnpm install

# Create .env file
cp .env.example .env
# Edit .env with your Supabase credentials

# Start dev server
pnpm dev

# Open http://localhost:5173
```

## Support

Need help?
- Check `README.md` for detailed documentation
- Review `SUPABASE_SETUP.md` for database setup
- See `DEPLOYMENT.md` for deployment details

## Congratulations! 🎉

You now have a production-ready, multi-tenant SaaS recruiting platform!

Your app is live at: `https://driveline-recruit-saas.vercel.app`

**What makes this special:**
- ✅ True multi-tenancy with data isolation
- ✅ Real database with demo data (not mocked!)
- ✅ Production-ready architecture
- ✅ Scalable and secure
- ✅ Full source code control
- ✅ No per-change costs

Time to build your recruiting empire! 🚛💼

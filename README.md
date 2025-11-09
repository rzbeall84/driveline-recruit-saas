# DriveLine Recruit SaaS

A production-ready, multi-tenant SaaS platform for driver recruiting companies. Built from scratch with React, TypeScript, Vite, Supabase, and Stripe.

## 🚀 Features

### Multi-Tenancy
- Complete tenant isolation with Row Level Security (RLS)
- Subdomain-based tenant routing
- Tenant-specific data and users

### Core Recruiting Features
- **Drivers Management**: Track driver applications, status, and information
- **Jobs Board**: Post and manage job listings
- **Recruiters**: Manage recruiting team members
- **Carriers**: Maintain carrier relationships and contacts
- **Chat**: Internal team communication
- **Email**: Integrated email management

### Subscription & Billing
- Stripe integration for payments
- Multiple subscription tiers (Starter, Professional, Enterprise)
- 14-day free trial
- Subscription management

### Security
- Supabase Authentication
- Row Level Security (RLS) for multi-tenancy
- Secure API routes
- Role-based access control (Admin, Recruiter, Viewer)

## 🛠️ Tech Stack

- **Frontend**: React 19, TypeScript, Vite
- **Styling**: Tailwind CSS, Radix UI
- **Backend**: Supabase (PostgreSQL, Auth, Storage)
- **Payments**: Stripe
- **Deployment**: Vercel
- **State Management**: TanStack Query (React Query)
- **Routing**: React Router v7

## 📦 Installation

1. Clone the repository:
```bash
git clone https://github.com/rzbeall84/driveline-recruit-saas.git
cd driveline-recruit-saas
```

2. Install dependencies:
```bash
pnpm install
```

3. Set up environment variables:
```bash
cp .env.example .env
```

Edit `.env` and add your Supabase and Stripe credentials:
```
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
VITE_STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
```

4. Set up Supabase database:
   - Go to your Supabase project dashboard
   - Navigate to SQL Editor
   - Run the schema: `supabase/schema.sql`
   - Run the seed data: `supabase/seed-demo-data.sql`

5. Start the development server:
```bash
pnpm dev
```

## 🗄️ Database Schema

### Tables
- `tenants` - Company/organization data
- `users` - User accounts with tenant association
- `drivers` - Driver applications and information
- `jobs` - Job postings
- `recruiters` - Recruiting team members
- `carriers` - Carrier companies
- `conversations` - Chat conversations
- `chat_messages` - Chat messages
- `emails` - Email records

### Multi-Tenancy Implementation
All tables include a `tenant_id` foreign key with RLS policies ensuring users can only access data from their own tenant.

## 🎨 Demo Data

The project includes realistic demo data:
- 3 demo tenants (companies)
- 6 admin/recruiter users
- 7 recruiters with profiles
- 10 carriers with full contact information
- 33 drivers with realistic details
- 12 job postings

**Note**: All demo data is saved to the database, not mocked.

## 🚢 Deployment

### Vercel Deployment

1. Install Vercel CLI:
```bash
pnpm add -g vercel
```

2. Deploy:
```bash
vercel
```

3. Set environment variables in Vercel dashboard

### Environment Variables
Required for production:
- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`
- `VITE_STRIPE_PUBLISHABLE_KEY`

## 📝 Project Structure

```
driveline-recruit-saas/
├── src/
│   ├── components/
│   │   ├── ui/           # Reusable UI components
│   │   ├── auth/         # Authentication components
│   │   ├── dashboard/    # Dashboard components
│   │   ├── drivers/      # Driver management
│   │   ├── jobs/         # Job management
│   │   ├── recruiters/   # Recruiter management
│   │   ├── carriers/     # Carrier management
│   │   ├── chat/         # Chat features
│   │   └── email/        # Email features
│   ├── contexts/         # React contexts
│   ├── hooks/            # Custom React hooks
│   ├── lib/              # Utility libraries
│   ├── pages/            # Page components
│   ├── types/            # TypeScript types
│   └── utils/            # Utility functions
├── supabase/
│   ├── schema.sql        # Database schema
│   └── seed-demo-data.sql # Demo data
└── public/               # Static assets
```

## 🔐 Authentication Flow

1. User signs up with company information
2. Tenant is created with unique subdomain
3. User account is created and linked to tenant
4. User can invite team members
5. All data is isolated by tenant_id

## 💳 Subscription Plans

### Starter - $99/month
- Up to 5 recruiters
- 100 active drivers
- Basic features

### Professional - $299/month
- Up to 20 recruiters
- 500 active drivers
- Advanced features
- Priority support

### Enterprise - Custom pricing
- Unlimited recruiters
- Unlimited drivers
- Custom features
- Dedicated support

## 🤝 Contributing

This is a private project. For questions or issues, contact the development team.

## 📄 License

Proprietary - All rights reserved

## 🔗 Links

- [Main App Repository](https://github.com/rzbeall84/driveline-recruit-app)
- [Supabase Project](https://supabase.com/dashboard/project/driveline-recruit-saas)

## 📞 Support

For support, email support@drivelinerecruit.com

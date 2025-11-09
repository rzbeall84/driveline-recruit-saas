import { useAuth } from '@/contexts/AuthContext'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Link } from 'react-router-dom'
import { Users, Briefcase, UserCheck, Truck, MessageSquare, Mail } from 'lucide-react'

export default function Dashboard() {
  const { profile, signOut } = useAuth()

  const menuItems = [
    { title: 'Drivers', description: 'Manage driver applications', icon: Users, path: '/drivers', color: 'bg-blue-500' },
    { title: 'Jobs', description: 'Post and manage job listings', icon: Briefcase, path: '/jobs', color: 'bg-green-500' },
    { title: 'Recruiters', description: 'Manage recruiting team', icon: UserCheck, path: '/recruiters', color: 'bg-purple-500' },
    { title: 'Carriers', description: 'Carrier relationships', icon: Truck, path: '/carriers', color: 'bg-orange-500' },
    { title: 'Chat', description: 'Team communication', icon: MessageSquare, path: '/chat', color: 'bg-pink-500' },
    { title: 'Email', description: 'Email management', icon: Mail, path: '/email', color: 'bg-indigo-500' },
  ]

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100">
      {/* Header */}
      <header className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex justify-between items-center">
            <div>
              <h1 className="text-2xl font-bold text-gray-900">DriveLine Recruit</h1>
              <p className="text-sm text-gray-600">
                Welcome back, {profile?.first_name} {profile?.last_name}
              </p>
            </div>
            <Button variant="outline" onClick={signOut}>
              Sign Out
            </Button>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-8">
          <h2 className="text-3xl font-bold text-gray-900 mb-2">Dashboard</h2>
          <p className="text-gray-600">Quick access to all your recruiting tools</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {menuItems.map((item) => (
            <Link key={item.path} to={item.path}>
              <Card className="hover:shadow-lg transition-shadow cursor-pointer h-full">
                <CardHeader>
                  <div className={`w-12 h-12 rounded-lg ${item.color} flex items-center justify-center mb-4`}>
                    <item.icon className="w-6 h-6 text-white" />
                  </div>
                  <CardTitle>{item.title}</CardTitle>
                  <CardDescription>{item.description}</CardDescription>
                </CardHeader>
              </Card>
            </Link>
          ))}
        </div>

        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mt-8">
          <Card>
            <CardHeader>
              <CardTitle className="text-sm font-medium text-gray-600">Total Drivers</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold">33</div>
              <p className="text-xs text-gray-500 mt-1">+12% from last month</p>
            </CardContent>
          </Card>
          <Card>
            <CardHeader>
              <CardTitle className="text-sm font-medium text-gray-600">Active Jobs</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold">12</div>
              <p className="text-xs text-gray-500 mt-1">Across all locations</p>
            </CardContent>
          </Card>
          <Card>
            <CardHeader>
              <CardTitle className="text-sm font-medium text-gray-600">Recruiters</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold">7</div>
              <p className="text-xs text-gray-500 mt-1">Active team members</p>
            </CardContent>
          </Card>
          <Card>
            <CardHeader>
              <CardTitle className="text-sm font-medium text-gray-600">Carriers</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold">10</div>
              <p className="text-xs text-gray-500 mt-1">Partner companies</p>
            </CardContent>
          </Card>
        </div>
      </main>
    </div>
  )
}

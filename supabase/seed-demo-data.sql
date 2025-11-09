-- This script creates realistic demo data for the DriveLine Recruit SaaS platform
-- All data will be inserted into the database, not mocked

-- Insert demo tenant
INSERT INTO tenants (id, name, subdomain, subscription_status, subscription_plan)
VALUES 
  ('11111111-1111-1111-1111-111111111111', 'Acme Trucking Solutions', 'acme-trucking', 'active', 'professional'),
  ('22222222-2222-2222-2222-222222222222', 'Swift Transport Group', 'swift-transport', 'active', 'enterprise'),
  ('33333333-3333-3333-3333-333333333333', 'Roadway Logistics Inc', 'roadway-logistics', 'trial', 'starter')
ON CONFLICT (id) DO NOTHING;

-- Insert demo admin users (these will need to be created in Supabase Auth first)
-- For now, we'll create placeholder user records that can be linked to auth users later
INSERT INTO users (id, tenant_id, email, role, first_name, last_name)
VALUES
  -- Acme Trucking admins and recruiters
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'admin@acmetrucking.com', 'admin', 'Sarah', 'Johnson'),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111', 'mike.recruiter@acmetrucking.com', 'recruiter', 'Mike', 'Thompson'),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', '11111111-1111-1111-1111-111111111111', 'lisa.recruiter@acmetrucking.com', 'recruiter', 'Lisa', 'Martinez'),
  
  -- Swift Transport users
  ('dddddddd-dddd-dddd-dddd-dddddddddddd', '22222222-2222-2222-2222-222222222222', 'admin@swifttransport.com', 'admin', 'John', 'Davis'),
  ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '22222222-2222-2222-2222-222222222222', 'recruiter@swifttransport.com', 'recruiter', 'Emily', 'Wilson'),
  
  -- Roadway Logistics users
  ('ffffffff-ffff-ffff-ffff-ffffffffffff', '33333333-3333-3333-3333-333333333333', 'admin@roadwaylogistics.com', 'admin', 'David', 'Brown')
ON CONFLICT (id) DO NOTHING;

-- Insert demo recruiters
INSERT INTO recruiters (id, tenant_id, user_id, first_name, last_name, email, phone, status, hire_date)
VALUES
  (uuid_generate_v4(), '11111111-1111-1111-1111-111111111111', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Mike', 'Thompson', 'mike.recruiter@acmetrucking.com', '555-0101', 'active', '2023-01-15'),
  (uuid_generate_v4(), '11111111-1111-1111-1111-111111111111', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'Lisa', 'Martinez', 'lisa.recruiter@acmetrucking.com', '555-0102', 'active', '2023-03-20'),
  (uuid_generate_v4(), '11111111-1111-1111-1111-111111111111', NULL, 'Robert', 'Garcia', 'robert.garcia@acmetrucking.com', '555-0103', 'active', '2023-06-10'),
  (uuid_generate_v4(), '11111111-1111-1111-1111-111111111111', NULL, 'Jennifer', 'Lee', 'jennifer.lee@acmetrucking.com', '555-0104', 'active', '2023-09-05'),
  
  (uuid_generate_v4(), '22222222-2222-2222-2222-222222222222', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Emily', 'Wilson', 'recruiter@swifttransport.com', '555-0201', 'active', '2022-11-01'),
  (uuid_generate_v4(), '22222222-2222-2222-2222-222222222222', NULL, 'James', 'Anderson', 'james.anderson@swifttransport.com', '555-0202', 'active', '2023-02-14'),
  
  (uuid_generate_v4(), '33333333-3333-3333-3333-333333333333', NULL, 'Maria', 'Rodriguez', 'maria.rodriguez@roadwaylogistics.com', '555-0301', 'active', '2024-01-10');

-- Insert demo carriers
INSERT INTO carriers (tenant_id, name, mc_number, dot_number, contact_name, contact_email, contact_phone, address, city, state, zip, status)
VALUES
  -- Acme Trucking carriers
  ('11111111-1111-1111-1111-111111111111', 'Prime Inc', 'MC-123456', 'DOT-789012', 'Tom Stevens', 'tstevens@primeinc.com', '417-555-0100', '2740 N Mayfair Ave', 'Springfield', 'MO', '65803', 'active'),
  ('11111111-1111-1111-1111-111111111111', 'Werner Enterprises', 'MC-234567', 'DOT-890123', 'Karen White', 'kwhite@werner.com', '402-555-0200', '14507 Frontier Rd', 'Omaha', 'NE', '68138', 'active'),
  ('11111111-1111-1111-1111-111111111111', 'Schneider National', 'MC-345678', 'DOT-901234', 'Paul Mitchell', 'pmitchell@schneider.com', '920-555-0300', '3101 S Packerland Dr', 'Green Bay', 'WI', '54313', 'active'),
  ('11111111-1111-1111-1111-111111111111', 'J.B. Hunt Transport', 'MC-456789', 'DOT-012345', 'Susan Clark', 'sclark@jbhunt.com', '479-555-0400', '615 J.B. Hunt Corporate Dr', 'Lowell', 'AR', '72745', 'active'),
  ('11111111-1111-1111-1111-111111111111', 'Knight-Swift Transportation', 'MC-567890', 'DOT-123456', 'Richard Hall', 'rhall@knightswift.com', '602-555-0500', '2002 W Pinnacle Peak Rd', 'Phoenix', 'AZ', '85027', 'active'),
  
  -- Swift Transport carriers
  ('22222222-2222-2222-2222-222222222222', 'Crete Carrier Corporation', 'MC-678901', 'DOT-234567', 'Nancy Turner', 'nturner@cretecarrier.com', '402-555-0600', '400 NW 56th St', 'Lincoln', 'NE', '68528', 'active'),
  ('22222222-2222-2222-2222-222222222222', 'Maverick Transportation', 'MC-789012', 'DOT-345678', 'Daniel King', 'dking@maverickusa.com', '501-555-0700', '10155 Kanis Rd', 'Little Rock', 'AR', '72211', 'active'),
  ('22222222-2222-2222-2222-222222222222', 'TMC Transportation', 'MC-890123', 'DOT-456789', 'Linda Wright', 'lwright@tmctrans.com', '515-555-0800', '201 1st St SE', 'Des Moines', 'IA', '50309', 'active'),
  
  -- Roadway Logistics carriers
  ('33333333-3333-3333-3333-333333333333', 'Roehl Transport', 'MC-901234', 'DOT-567890', 'Michael Green', 'mgreen@roehl.net', '715-555-0900', '3450 Venture Dr', 'Marshfield', 'WI', '54449', 'active'),
  ('33333333-3333-3333-3333-333333333333', 'USA Truck', 'MC-012345', 'DOT-678901', 'Patricia Adams', 'padams@usatruck.com', '479-555-1000', '3200 Industrial Park Rd', 'Van Buren', 'AR', '72956', 'active');

-- Insert demo drivers
INSERT INTO drivers (tenant_id, first_name, last_name, email, phone, cdl_number, cdl_state, status, recruiter_id, notes)
VALUES
  -- Acme Trucking drivers
  ('11111111-1111-1111-1111-111111111111', 'James', 'Miller', 'james.miller@email.com', '555-1001', 'CDL123456', 'TX', 'active', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Experienced OTR driver, 5 years clean record'),
  ('11111111-1111-1111-1111-111111111111', 'Patricia', 'Wilson', 'patricia.wilson@email.com', '555-1002', 'CDL234567', 'CA', 'active', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Regional driver, excellent safety record'),
  ('11111111-1111-1111-1111-111111111111', 'Robert', 'Moore', 'robert.moore@email.com', '555-1003', 'CDL345678', 'FL', 'interviewing', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'New CDL holder, eager to start'),
  ('11111111-1111-1111-1111-111111111111', 'Mary', 'Taylor', 'mary.taylor@email.com', '555-1004', 'CDL456789', 'OH', 'lead', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'Interested in flatbed work'),
  ('11111111-1111-1111-1111-111111111111', 'Michael', 'Anderson', 'michael.anderson@email.com', '555-1005', 'CDL567890', 'IL', 'active', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Team driver, 10+ years experience'),
  ('11111111-1111-1111-1111-111111111111', 'Linda', 'Thomas', 'linda.thomas@email.com', '555-1006', 'CDL678901', 'PA', 'application', NULL, 'Hazmat endorsed, looking for local routes'),
  ('11111111-1111-1111-1111-111111111111', 'William', 'Jackson', 'william.jackson@email.com', '555-1007', 'CDL789012', 'GA', 'active', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Tanker experience, 7 years'),
  ('11111111-1111-1111-1111-111111111111', 'Barbara', 'White', 'barbara.white@email.com', '555-1008', 'CDL890123', 'NC', 'lead', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'Seeking better pay and benefits'),
  ('11111111-1111-1111-1111-111111111111', 'David', 'Harris', 'david.harris@email.com', '555-1009', 'CDL901234', 'TN', 'interviewing', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Military veteran, Class A CDL'),
  ('11111111-1111-1111-1111-111111111111', 'Elizabeth', 'Martin', 'elizabeth.martin@email.com', '555-1010', 'CDL012345', 'AZ', 'active', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'Dedicated route driver, 3 years'),
  ('11111111-1111-1111-1111-111111111111', 'Richard', 'Thompson', 'richard.thompson@email.com', '555-1011', 'CDL123457', 'NV', 'lead', NULL, 'Recent CDL school graduate'),
  ('11111111-1111-1111-1111-111111111111', 'Susan', 'Garcia', 'susan.garcia@email.com', '555-1012', 'CDL234568', 'WA', 'application', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Doubles/triples endorsed'),
  ('11111111-1111-1111-1111-111111111111', 'Joseph', 'Martinez', 'joseph.martinez@email.com', '555-1013', 'CDL345679', 'OR', 'active', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'Refrigerated freight specialist'),
  ('11111111-1111-1111-1111-111111111111', 'Jessica', 'Robinson', 'jessica.robinson@email.com', '555-1014', 'CDL456780', 'CO', 'interviewing', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Owner operator looking for lease'),
  ('11111111-1111-1111-1111-111111111111', 'Thomas', 'Clark', 'thomas.clark@email.com', '555-1015', 'CDL567891', 'MI', 'lead', NULL, 'Interested in training program'),
  
  -- Swift Transport drivers
  ('22222222-2222-2222-2222-222222222222', 'Christopher', 'Rodriguez', 'chris.rodriguez@email.com', '555-2001', 'CDL678902', 'NY', 'active', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Northeast regional driver'),
  ('22222222-2222-2222-2222-222222222222', 'Sarah', 'Lewis', 'sarah.lewis@email.com', '555-2002', 'CDL789013', 'NJ', 'active', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Port driver, 6 years experience'),
  ('22222222-2222-2222-2222-222222222222', 'Daniel', 'Lee', 'daniel.lee@email.com', '555-2003', 'CDL890124', 'MA', 'lead', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Looking for better home time'),
  ('22222222-2222-2222-2222-222222222222', 'Nancy', 'Walker', 'nancy.walker@email.com', '555-2004', 'CDL901235', 'CT', 'interviewing', NULL, 'Experienced with electronic logs'),
  ('22222222-2222-2222-2222-222222222222', 'Matthew', 'Hall', 'matthew.hall@email.com', '555-2005', 'CDL012346', 'VA', 'active', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Dedicated Walmart account driver'),
  ('22222222-2222-2222-2222-222222222222', 'Karen', 'Allen', 'karen.allen@email.com', '555-2006', 'CDL123458', 'MD', 'application', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Seeking sign-on bonus'),
  ('22222222-2222-2222-2222-222222222222', 'Paul', 'Young', 'paul.young@email.com', '555-2007', 'CDL234569', 'SC', 'active', NULL, 'Flatbed specialist, 8 years'),
  ('22222222-2222-2222-2222-222222222222', 'Betty', 'Hernandez', 'betty.hernandez@email.com', '555-2008', 'CDL345680', 'AL', 'lead', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Recent career change to trucking'),
  
  -- Roadway Logistics drivers
  ('33333333-3333-3333-3333-333333333333', 'Mark', 'King', 'mark.king@email.com', '555-3001', 'CDL456781', 'MN', 'active', NULL, 'Upper Midwest regional'),
  ('33333333-3333-3333-3333-333333333333', 'Lisa', 'Wright', 'lisa.wright@email.com', '555-3002', 'CDL567892', 'WI', 'lead', NULL, 'Dairy hauler, 4 years'),
  ('33333333-3333-3333-3333-333333333333', 'Steven', 'Lopez', 'steven.lopez@email.com', '555-3003', 'CDL678903', 'IA', 'interviewing', NULL, 'Grain hauling experience'),
  ('33333333-3333-3333-3333-333333333333', 'Donna', 'Hill', 'donna.hill@email.com', '555-3004', 'CDL789014', 'ND', 'application', NULL, 'Oil field experience'),
  ('33333333-3333-3333-3333-333333333333', 'Kenneth', 'Scott', 'kenneth.scott@email.com', '555-3005', 'CDL890125', 'SD', 'active', NULL, 'Livestock hauler');

-- Insert demo jobs
INSERT INTO jobs (tenant_id, title, company_name, location, job_type, pay_range, description, requirements, status, created_by)
VALUES
  -- Acme Trucking jobs
  ('11111111-1111-1111-1111-111111111111', 'OTR Class A CDL Driver', 'Acme Trucking Solutions', 'Dallas, TX', 'Over The Road', '$65,000 - $85,000/year', 'Seeking experienced OTR drivers for long-haul routes across the continental US. Modern fleet, excellent benefits, and competitive pay.', 'Valid Class A CDL, 2+ years OTR experience, clean MVR, ability to be away from home 2-3 weeks', 'active', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  ('11111111-1111-1111-1111-111111111111', 'Regional CDL Driver - Home Weekly', 'Acme Trucking Solutions', 'Atlanta, GA', 'Regional', '$60,000 - $75,000/year', 'Regional routes with guaranteed home time every weekend. Modern equipment and excellent benefits package.', 'Valid Class A CDL, 1+ years experience, clean driving record', 'active', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  ('11111111-1111-1111-1111-111111111111', 'Local Delivery Driver', 'Acme Trucking Solutions', 'Chicago, IL', 'Local', '$55,000 - $70,000/year', 'Home daily! Local delivery routes in the Chicago metro area. Day shift available.', 'Valid Class A or B CDL, local experience preferred, clean MVR', 'active', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  ('11111111-1111-1111-1111-111111111111', 'Team Drivers - OTR', 'Acme Trucking Solutions', 'Phoenix, AZ', 'Over The Road', '$120,000 - $150,000/year (team)', 'High-earning opportunity for team drivers. Consistent miles and top pay in the industry.', 'Valid Class A CDL, team driving experience preferred, willing to run coast-to-coast', 'active', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  ('11111111-1111-1111-1111-111111111111', 'Flatbed Driver - Specialized', 'Acme Trucking Solutions', 'Houston, TX', 'Specialized', '$70,000 - $90,000/year', 'Flatbed drivers needed for specialized freight. Tarping and securement experience required.', 'Valid Class A CDL, flatbed experience, able to tarp and secure loads, clean MVR', 'active', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  
  -- Swift Transport jobs
  ('22222222-2222-2222-2222-222222222222', 'Dedicated Route Driver', 'Swift Transport Group', 'Newark, NJ', 'Dedicated', '$65,000 - $80,000/year', 'Dedicated account with consistent schedule and excellent home time. Modern Freightliners.', 'Valid Class A CDL, 1+ years experience, clean driving record', 'active', 'dddddddd-dddd-dddd-dddd-dddddddddddd'),
  ('22222222-2222-2222-2222-222222222222', 'Refrigerated Freight Driver', 'Swift Transport Group', 'Charlotte, NC', 'Over The Road', '$68,000 - $88,000/year', 'Reefer drivers needed for temperature-controlled freight. Top pay and benefits.', 'Valid Class A CDL, reefer experience preferred, 2+ years OTR', 'active', 'dddddddd-dddd-dddd-dddd-dddddddddddd'),
  ('22222222-2222-2222-2222-222222222222', 'Tanker Driver - Hazmat', 'Swift Transport Group', 'Baltimore, MD', 'Specialized', '$75,000 - $95,000/year', 'Hazmat tanker drivers needed. Premium pay for specialized work.', 'Valid Class A CDL with Hazmat and Tanker endorsements, 3+ years experience', 'active', 'dddddddd-dddd-dddd-dddd-dddddddddddd'),
  ('22222222-2222-2222-2222-222222222222', 'Port Drayage Driver', 'Swift Transport Group', 'Long Beach, CA', 'Local', '$70,000 - $85,000/year', 'Port drayage drivers needed for container work. Home daily.', 'Valid Class A CDL, port experience preferred, TWIC card required', 'active', 'dddddddd-dddd-dddd-dddd-dddddddddddd'),
  
  -- Roadway Logistics jobs
  ('33333333-3333-3333-3333-333333333333', 'Regional Driver - Midwest', 'Roadway Logistics Inc', 'Minneapolis, MN', 'Regional', '$62,000 - $78,000/year', 'Midwest regional routes with excellent home time. Modern equipment.', 'Valid Class A CDL, 1+ years experience, clean MVR', 'active', 'ffffffff-ffff-ffff-ffff-ffffffffffff'),
  ('33333333-3333-3333-3333-333333333333', 'Owner Operator - Lease Program', 'Roadway Logistics Inc', 'Des Moines, IA', 'Owner Operator', '$150,000 - $200,000/year (gross)', 'Excellent lease purchase program with no money down. High earning potential.', 'Valid Class A CDL, 2+ years experience, good credit preferred', 'active', 'ffffffff-ffff-ffff-ffff-ffffffffffff'),
  ('33333333-3333-3333-3333-333333333333', 'CDL Training Program', 'Roadway Logistics Inc', 'Milwaukee, WI', 'Training', '$45,000 - $55,000/year (starting)', 'Paid CDL training program for new drivers. No experience necessary!', 'Valid drivers license, clean background check, willing to obtain CDL', 'active', 'ffffffff-ffff-ffff-ffff-ffffffffffff');

-- Note: Chat messages and emails will be generated dynamically in the application
-- to show realistic conversation flows between recruiters and drivers

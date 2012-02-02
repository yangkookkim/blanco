# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Create groups
g1 = Group.create(:name => "lunch", :is_feedbackgroup => false, :due => "", :share_with => "")
g2 = Group.create(:name => "to2", :is_feedbackgroup => false, :due => "", :share_with => "")
g3 = Group.create(:name => "iaas", :is_feedbackgroup => false, :due => "", :share_with => "")
g4 = Group.create(:name => "dev", :is_feedbackgroup => false, :due => "", :share_with => "")
g5 = Group.create(:name => "complain", :is_feedbackgroup => false, :due => "", :share_with => "")
g6 = Group.create(:name => "nico", :is_feedbackgroup => false, :due => "", :share_with => "")
# Create employees
f = File.open("#{Rails.root}/app/assets/images/noimage.gif")
e1 = Employee.create(:name => "Kim, Hirokuni",:icon => f) 
e2 = Employee.create(:name => "Ogawa, Junpei",:icon => f)
e3 = Employee.create(:name => "Shu, Tosei",:icon => f)
e4 = Employee.create(:name => "Yamazaki, Takehiro",:icon => f)
e5 = Employee.create(:name => "Umeda, Hisakazu",:icon => f)
e6 = Employee.create(:name => "Okada, Munetoshi",:icon => f)
e7 = Employee.create(:name => "Imaizumi, Natsuko",:icon => f)
e8 = Employee.create(:name => "Namihira, Hiroo",:icon => f)
e9 = Employee.create(:name => "Matsuda, Yasuaki",:icon => f)
e10 = Employee.create(:name => "Mui, Andrew",:icon => f)
# Add employees to groups
g1.employees << e1 << e2 << e3 << e4 << e5 << e6 << e7 << e8 << e9
g2.employees << e1 << e2 << e3 << e4 << e5 << e6 << e7 << e8 << e9
g3.employees << e1 << e2 << e3
g4.employees << e10
g5.employees << e1 << e2 << e3 << e4 << e6 << e7 << e8 << e9
g6.employees << e1 << e2
# Create profile
p1 = Profile.create(:tel => "03-4560-1111", :email => "kimh@kvh.co.jp", :department => "Service Operation", :nationality => "Korea", :workplace => "Tamachi")
p2 = Profile.create(:tel => "03-4560-2222", :email => "ogawaj@kvh.co.jp", :department => "Service Operation", :nationality => "Japan", :workplace => "Tamachi")
p3 = Profile.create(:tel => "03-4560-3333", :email => "shut@kvh.co.jp", :department => "Service Operation", :nationality => "China", :workplace => "Tamachi")
p4 = Profile.create(:tel => "03-4560-4444", :email => "yamazakit@kvh.co.jp", :department => "Service Operation", :nationality => "Japan", :workplace => "Tamachi")
p5 = Profile.create(:tel => "03-4560-5555", :email => "umedah@kvh.co.jp", :department => "Service Operation", :nationality => "Japan", :workplace => "Tamachi")
p6 = Profile.create(:tel => "03-4560-6666", :email => "okadam@kvh.co.jp", :department => "Service Operation", :nationality => "Japan", :workplace => "Tamachi")
p7 = Profile.create(:tel => "03-4560-7777", :email => "imaizumin@kvh.co.jp", :department => "Service Operation", :nationality => "Japan", :workplace => "Tamachi")
p8 = Profile.create(:tel => "03-4560-8888", :email => "namihirah@kvh.co.jp", :department => "Service Operation", :nationality => "Japan", :workplace => "Tamachi")
p9 = Profile.create(:tel => "03-4560-9999", :email => "matsuday@kvh.co.jp", :department => "Service Operation", :nationality => "Japan", :workplace => "Tamachi")
p10 = Profile.create(:tel => "03-4560-0000", :email => "muia@kvh.co.jp", :department => "Service Operation", :nationality => "USA", :workplace => "Tamachi")
# Add profiles to employees
e1.profile = p1
e2.profile = p2
e3.profile = p3
e4.profile = p4
e5.profile = p5
e6.profile = p6
e7.profile = p7
e8.profile = p8
e9.profile = p9
e10.profile = p10
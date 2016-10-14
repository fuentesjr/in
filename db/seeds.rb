# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
profile_data = [ {"fullname"=>"Brian Thomas", "company"=>"Clutter", "title"=>"CEO at Clutter", "position"=>"CEO", "skills"=>["copywriting", "digital marketing", "direct marketing", "marketing communications", "marketing strategy", "multi-channel marketing", "online advertising", "product marketing", "project management", "seo", "social media marketing", "strategic planning"]},
  {"fullname"=>"Satya Nadella", "company"=>"Microsoft", "title"=>"CEO at Microsoft", "position"=>"CEO", "skills"=>[]},
  {"fullname"=>"Larry Page", "company"=>"Alphabet", "title"=>"CEO at Alphabet Inc.", "position"=>"CEO", "skills"=>[]},
  {"fullname"=>"Demis Hassabis", "company"=>"DeepMind", "title"=>"Founder & CEO, DeepMind", "position"=>"Founder & CEO", "skills"=>["algorithms", "applied mathematics", "artificial intelligence", "c++", "cognitive neuroscience", "computer games", "computer science", "computer vision", "game design", "game development", "image processing", "machine learning", "mathematical modeling", "matlab", "optimization", "pattern recognition", "programming", "software engineering", "start-ups", "statistics", "video games"]},
  {"fullname"=>"Jeff Weiner", "company"=>"LinkedIn", "title"=>"CEO at LinkedIn", "position"=>"CEO", "skills"=>["analytics", "awesomeness", "business operations", "business strategy", "corporate developmentproduct marketing", "education", "entrepreneurship", "executive management", "leadership", "leadership development", "linkedin", "mentoring", "mergers & acquisitions", "mobile applications", "motivation", "non-profits", "nonprofits", "product development", "product management", "social media", "strategic planning", "strategy", "team leadership", "thought leadership", "user experience"]},
  {"fullname"=>"Stephen Wolfram", "company"=>"Wolfram Research", "title"=>"Founder & CEO at Wolfram Research", "position"=>"Founder & CEO", "skills"=>["algorithms", "computer science", "high performancedata mining", "machine learning", "mathematica", "mathematical modeling", "physics", "programming", "wolfram language"]},
  {"fullname"=>"Adam D'Angelo", "company"=>"Quora", "title"=>"Founder & CEO at Quora", "position"=>"CEO", "skills"=>[]},
  {"fullname"=>"Rich Hickey", "company"=>"Cognitect", "title"=>"CTO at Cognitect", "position"=>"CTO", "skills"=>[]},
  {"fullname"=>"Jessica Noss", "company"=>"Massachusetts Institute of Technology (MIT)", "title"=>"Research Assistant in Artificial Intelligence - Genesis Group (Patrick Winston) at MIT", "position"=>"Research Assistant in Artificial Intelligence - Genesis Group (Patrick Winston)", "skills"=>["administration", "artificial intelligence", "c#", "copy editing", "css", "event planning", "html", "java", "javascript", "jquery", "leading meetings", "python", "software development", "software engineering", "spreadsheets", "teaching", "user interface design"]}
]

ActiveRecord::Base.transaction do
  profile_data.each do |pdata|
    new_profile = Profile.new(pdata.except("skills"))
    pdata["skills"].each do |skill|
      new_profile.skills.build(name: skill)
    end
    new_profile.save
  end
end

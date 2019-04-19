SELECT  profiles.id, profiles.fullname, string_agg(skills.name, ', ') AS skills
FROM profiles
INNER JOIN profiles_skills ON profiles_skills.profile_id = profiles.id
INNER JOIN skills ON skills.id = profiles_skills.skill_id
GROUP BY profiles.id
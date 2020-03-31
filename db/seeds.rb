#This is were we create some see data to test associations

meghan = User.create(name: "Meghan", username: "meghan@aerialapp.com", password: "password")
kelsey = User.create(name: "Kelsey", username: "kelsey@aerialapp.com", password: "password")

AerialEntry.create(user_id: meghan.id, move_name: "Half Angel", apparatus: "Lyra", difficulty: "Beginner", 
description: "You are hanging from the bottom bar of the hoop and are facing the ground. 
One hand and the top of your opposite leg should be on the bottom bar of the hoop.", image: "https://i.pinimg.com/564x/c4/e5/73/c4e57349458723d346ebbb82c2e148a0.jpg")

meghan.aerial_entries.create(move_name: "Allegra", apparatus: "Pole", difficulty: "Advanced", description: "Invert and get into inside leg hang. 
Extend top leg and reach around with bottom arm to grab other leg.", image: "https://i.pinimg.com/originals/6a/c6/e0/6ac6e00a259a23b46f19e5ac3ec912f5.jpg")

kelseys_entry = kelsey.aerial_entries.build(move_name: "Cross Back Straddle", apparatus: "Silks", difficulty: "Beginner", 
description: "Footlock. Stand. Bring one hand through middle of silks. Push shoulders forward. Let go of one silk and bring behind
Opposite silks should be in each hand. Pull hands toward shoulder. Lean back through the middle of the silks. Bring hands to front.
Put cross silks to lower back. Invert", image: "https://www.aerialsilksatlanta.com/wp-content/uploads/2014/12/DestinationClasses.jpg")
kelseys_entry.save
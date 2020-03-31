#This is were we create some see data to test associations

meghan = User.create(name: "Meghan", email: "meghan@aerialapp.com", password: "password")
kelsey = User.create(name: "Kelsey", email: "kelsey@aerialapp.com", password: "password")

AerialEntry.create(user_id: meghan.id, move_name: "Half Angel", apparatus: "Lyra", difficulty: "Beginner", 
description: "You are hanging from the bottom bar of the hoop and are facing the ground. 
One hand and the top of your opposite leg should be on the bottom bar of the hoop." image: "still figuring this out")

meghan.aerial_entries.create(move_name: "Allegra", apparatus: "Pole", difficulty: "Advanced", description: "Invert and get into inside leg hang. 
Extend top leg and reach around with bottom arm to grab other leg." image: "still figuring this out")

kelseys_entry = kelsey.aerial_entries.build(move_name: "Cross Back Straddle", apparatus: "Silks", difficulty: "Beginner", 
description: "Footlock. Stand. Bring one hand through middle of silks. Push shoulders forward. Let go of one silk and bring behind
Opposite silks should be in each hand. Pull hands toward shoulder. Lean back through the middle of the silks. Bring hands to front.
Put cross silks to lower back. Invert", image: "still figuring this out")
kelseys_entry.save
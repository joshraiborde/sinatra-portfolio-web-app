

adam = User.create(name: "Adam", email: "adam@adam.com", password: "password")
eve = User.create(name: "Eve", email: "eve@eve.com", password: "password")

DevotionEntry.create(content: "Wife brought me some fruit!", user_id: adam.id)

adam.devotion_entries.create(content: "Fruit tastes wierd.")

eves_entry = eve.devotion_entries.build(content: "Found some fruit!")
eves_entry.save
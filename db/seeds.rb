# ==============================================================================
# TravelMaster Database Seeds
# World-class destinations, hotels, transports, routes, forecasts & demo users
# ==============================================================================

puts "🌍 Seeding TravelMaster database..."
puts "=" * 60

# Clean existing seed data
puts "🧹 Clearing existing records..."
Alert.delete_all
CrowdForecast.delete_all
WeatherForecast.delete_all
RoutesInfo.delete_all
TripBooking.delete_all
TripDestination.delete_all
Trip.delete_all
Transport.delete_all
Hotel.delete_all
Destination.delete_all
User.delete_all

# ==============================================================================
# USERS
# ==============================================================================
puts "\n👤 Creating users..."

admin = User.create!(
  name: "Admin User",
  email: "admin@travelmaster.com",
  password: "password123",
  password_confirmation: "password123",
  role: "admin",
  travel_preference: "luxury",
  default_currency: "USD"
)

traveler = User.create!(
  name: "Alex Traveler",
  email: "traveler@travelmaster.com",
  password: "password123",
  password_confirmation: "password123",
  role: "user",
  travel_preference: "moderate",
  default_currency: "USD"
)

puts "  ✅ Created #{User.count} users"

# ==============================================================================
# DESTINATIONS
# ==============================================================================
puts "\n📍 Creating destinations..."

destinations_data = [
  {
    name: "Tokyo", city: "Tokyo", country: "Japan",
    description: "A mesmerizing blend of ultramodern and traditional — neon-lit skyscrapers tower alongside serene temples and cherry-blossom parks. Tokyo is the world's most populous metropolis, offering everything from Michelin-starred cuisine to ancient shrines.",
    price: 180, category: "Urban & Modern", rating: 4.9, available: true, is_domestic: false,
    best_season: "Spring (March-May) & Autumn (Sept-Nov)",
    popular_attractions: "Shibuya Crossing, Senso-ji Temple, Tokyo Tower, Tsukiji Market, Akihabara, Harajuku, Shinjuku Gyoen",
    image_url: "https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=800",
    latitude: 35.6762, longitude: 139.6503
  },
  {
    name: "Paris", city: "Paris", country: "France",
    description: "The City of Light is the world's leading tourist destination — a place where art, fashion, cuisine, and romance converge on grand boulevards and alongside the iconic Seine River.",
    price: 210, category: "Cultural & Historic", rating: 4.8, available: true, is_domestic: false,
    best_season: "Spring (April-June) & Autumn (Sept-Oct)",
    popular_attractions: "Eiffel Tower, The Louvre, Notre-Dame Cathedral, Musée d'Orsay, Palace of Versailles, Champs-Élysées, Montmartre",
    image_url: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800",
    latitude: 48.8566, longitude: 2.3522
  },
  {
    name: "Bali", city: "Denpasar", country: "Indonesia",
    description: "An Island of Gods, Bali enchants visitors with its dramatic volcanic mountains, terraced rice paddies, tranquil beaches, and vibrant Hindu culture. A perfect fusion of spiritual retreat and tropical paradise.",
    price: 95, category: "Tropical Beach", rating: 4.7, available: true, is_domestic: false,
    best_season: "Dry Season (April-October)",
    popular_attractions: "Ubud Rice Terraces, Tanah Lot Temple, Mount Batur, Seminyak Beach, Monkey Forest, Uluwatu Temple",
    image_url: "https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800",
    latitude: -8.3405, longitude: 115.0920
  },
  {
    name: "Rome", city: "Rome", country: "Italy",
    description: "The Eternal City sits atop 28 centuries of history. Ancient forums, Renaissance palaces, and Baroque fountains coexist with vibrant street life, sublime cuisine, and world-class galleries.",
    price: 175, category: "Cultural & Historic", rating: 4.8, available: true, is_domestic: false,
    best_season: "Spring (April-May) & Autumn (Sept-Oct)",
    popular_attractions: "Colosseum, Vatican Museums & Sistine Chapel, Trevi Fountain, Roman Forum, Pantheon, Piazza Navona, Borghese Gallery",
    image_url: "https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=800",
    latitude: 41.9028, longitude: 12.4964
  },
  {
    name: "Hunza Valley", city: "Karimabad", country: "Pakistan",
    description: "Often called the 'Shangri-La of Pakistan', Hunza Valley is a breathtaking mountain paradise in the Karakoram range. Ancient forts, apricot orchades, and towering glacier-capped peaks make this one of Asia's most spectacular destinations.",
    price: 55, category: "Mountain & Nature", rating: 4.9, available: true, is_domestic: true,
    best_season: "Summer (May-September) & Spring Blossom (March-April)",
    popular_attractions: "Rakaposhi Peak View, Baltit Fort, Attabad Lake, Eagle's Nest, Khunjerab Pass, Passu Cones, Altit Fort",
    image_url: "https://images.unsplash.com/photo-1605649487212-47bdab064df7?w=800",
    latitude: 36.3167, longitude: 74.6500
  },
  {
    name: "New York City", city: "New York", country: "USA",
    description: "The Big Apple never sleeps — an electrifying global hub of finance, arts, fashion, and culture. From Times Square's dazzling lights to Central Park's tranquil green oasis, New York is the city that defines modern ambition.",
    price: 250, category: "Urban & Modern", rating: 4.7, available: true, is_domestic: false,
    best_season: "Spring (April-June) & Autumn (Sept-Nov)",
    popular_attractions: "Statue of Liberty, Central Park, Times Square, Empire State Building, Brooklyn Bridge, Metropolitan Museum, High Line",
    image_url: "https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=800",
    latitude: 40.7128, longitude: -74.0060
  },
  {
    name: "Swiss Alps", city: "Interlaken", country: "Switzerland",
    description: "The Swiss Alps offer the most iconic mountain scenery on Earth — towering summits, pristine glaciers, emerald lakes, and charming villages. Whether skiing in winter or hiking in summer, this is nature at its most dramatic.",
    price: 320, category: "Mountain & Nature", rating: 4.9, available: true, is_domestic: false,
    best_season: "Winter (Dec-March) for skiing • Summer (June-Sept) for hiking",
    popular_attractions: "Jungfraujoch Top of Europe, Matterhorn, Lake Thun, Harder Kulm, Trümmelbach Falls, Grindelwald Glacier, Bernese Oberland",
    image_url: "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800",
    latitude: 46.6863, longitude: 7.8632
  },
  {
    name: "Dubai", city: "Dubai", country: "UAE",
    description: "A city of jaw-dropping superlatives — tallest building, largest shopping mall, most luxurious hotels. Dubai seamlessly blends ultramodern architecture with Arabian traditions, offering a one-of-a-kind desert luxury experience.",
    price: 280, category: "Luxury & Desert", rating: 4.7, available: true, is_domestic: false,
    best_season: "Winter (November-March)",
    popular_attractions: "Burj Khalifa, Dubai Mall, Palm Jumeirah, Dubai Creek, Desert Safari, Gold Souk, Burj Al Arab, Dubai Frame",
    image_url: "https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=800",
    latitude: 25.2048, longitude: 55.2708
  },
  {
    name: "Barcelona", city: "Barcelona", country: "Spain",
    description: "A sensory city where Gaudí's surreal architecture, Mediterranean beaches, and world-renowned gastronomy create an irresistible tapestry. Barcelona is a city that celebrates life — art, football, tapas, and vibrant nightlife.",
    price: 165, category: "Cultural & Historic", rating: 4.8, available: true, is_domestic: false,
    best_season: "Spring (April-June) & Early Autumn (Sept-Oct)",
    popular_attractions: "Sagrada Família, Park Güell, Gothic Quarter, La Rambla, Camp Nou, Barceloneta Beach, Picasso Museum, Casa Batlló",
    image_url: "https://images.unsplash.com/photo-1539037116277-4db20889f2d4?w=800",
    latitude: 41.3851, longitude: 2.1734
  },
  {
    name: "Kyoto", city: "Kyoto", country: "Japan",
    description: "Japan's ancient imperial capital preserves the soul of traditional Japanese culture. With over 2,000 temples and shrines, moss-covered bamboo groves, geisha districts, and zen gardens, Kyoto is the ultimate authentic Japan experience.",
    price: 150, category: "Cultural & Historic", rating: 4.9, available: true, is_domestic: false,
    best_season: "Spring Cherry Blossoms (March-April) & Autumn Foliage (Nov)",
    popular_attractions: "Fushimi Inari Shrine, Arashiyama Bamboo Grove, Kinkaku-ji Golden Pavilion, Gion Geisha District, Nijo Castle, Philosopher's Path",
    image_url: "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=800",
    latitude: 35.0116, longitude: 135.7681
  },
  {
    name: "Cape Town", city: "Cape Town", country: "South Africa",
    description: "Spectacularly positioned between ocean and mountain, Cape Town is Africa's most cosmopolitan city. Table Mountain's flat summit, the Cape Winelands, and stunning beaches make this one of the world's most beautiful destinations.",
    price: 130, category: "Mountain & Nature", rating: 4.8, available: true, is_domestic: false,
    best_season: "Summer (November-March)",
    popular_attractions: "Table Mountain, Cape of Good Hope, Robben Island, V&A Waterfront, Boulders Beach Penguins, Stellenbosch Wine Route, Chapman's Peak",
    image_url: "https://images.unsplash.com/photo-1580060839134-75a5edca2e99?w=800",
    latitude: -33.9249, longitude: 18.4241
  },
  {
    name: "Maldives", city: "Malé", country: "Maldives",
    description: "The Maldives is a necklace of 1,200 coral islands scattered across the Indian Ocean — crystal turquoise lagoons, powder-white sandbars, and unparalleled overwater bungalow luxury. The world's ultimate beach escape.",
    price: 450, category: "Tropical Beach", rating: 5.0, available: true, is_domestic: false,
    best_season: "Dry Season (November-April)",
    popular_attractions: "Overwater Bungalows, Coral Reef Snorkeling, Whale Shark Diving, Sunset Dolphin Cruise, North Malé Atoll, Bioluminescent Beach",
    image_url: "https://images.unsplash.com/photo-1514282401047-d79a71a590e8?w=800",
    latitude: 3.2028, longitude: 73.2207
  },
  {
    name: "Lahore", city: "Lahore", country: "Pakistan",
    description: "Pakistan's cultural heart beats with centuries of Mughal heritage, legendary street food, and a vibrant arts scene. The Walled City, grand mosques, and festive bazaars make Lahore an unforgettable sensory journey.",
    price: 35, category: "Cultural & Historic", rating: 4.5, available: true, is_domestic: true,
    best_season: "Winter (October-February)",
    popular_attractions: "Badshahi Mosque, Lahore Fort, Shalimar Gardens, Food Street Gawalmandi, Walled City, National Museum, Wagah Border Ceremony",
    image_url: "https://images.unsplash.com/photo-1566552881560-0be862a7c445?w=800",
    latitude: 31.5204, longitude: 74.3587
  },
  {
    name: "Swat Valley", city: "Mingora", country: "Pakistan",
    description: "Known as the 'Switzerland of Pakistan', Swat Valley captivates with its emerald rivers, snow-dusted mountains, lush green meadows, and Buddhist ruins. A hidden paradise for nature lovers and trekkers.",
    price: 45, category: "Adventure & Trekking", rating: 4.6, available: true, is_domestic: true,
    best_season: "Summer (May-September)",
    popular_attractions: "Malam Jabba Ski Resort, Fizagat Park, Swat River, Marghazar Valley, Buddhist Stupa Ruins, Kalam Valley, Mahodand Lake",
    image_url: "https://images.unsplash.com/photo-1585938389612-a552a28d6914?w=800",
    latitude: 35.3213, longitude: 72.3597
  },
  {
    name: "Santorini", city: "Thira", country: "Greece",
    description: "Iconic white-washed buildings with vivid blue domes perched on dramatic volcanic cliffs above the deep cobalt Aegean Sea. Santorini delivers one of the world's most photographed sunsets and a refined Mediterranean lifestyle.",
    price: 290, category: "Tropical Beach", rating: 4.9, available: true, is_domestic: false,
    best_season: "Late Spring (May-June) & Early Autumn (Sept-Oct)",
    popular_attractions: "Oia Sunset, Caldera Views, Akrotiri Archaeological Site, Red Beach, Amoudi Bay, Wine Tasting, Fira Town, Black Sand Beach",
    image_url: "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800",
    latitude: 36.3932, longitude: 25.4615
  }
]

destinations = {}
destinations_data.each do |data|
  dest = Destination.create!(data)
  destinations[data[:name]] = dest
  print "  ✅ #{dest.name}\n"
end

puts "  📊 Total destinations: #{Destination.count}"

# ==============================================================================
# HOTELS
# ==============================================================================
puts "\n🏨 Creating hotels..."

hotels_data = [
  # Tokyo Hotels
  { destination: "Tokyo", name: "Park Hyatt Tokyo", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 650, available_rooms: 12, amenities: "Infinity Pool, Spa & Wellness, Rooftop Bar, Michelin Restaurant, City Panorama Views, Concierge 24/7", description: "Iconic luxury hotel on the 39th-52nd floors of Shinjuku Park Tower with breathtaking skyline views." },
  { destination: "Tokyo", name: "Shinjuku Granbell Hotel", hotel_type: "Boutique Hotel", star_rating: 4, price_per_night: 185, available_rooms: 32, amenities: "Rooftop Terrace, Free WiFi, Bar & Lounge, Artsy Design Rooms", description: "Stylish boutique hotel in the heart of Shinjuku with artfully designed rooms." },
  { destination: "Tokyo", name: "Sakura Budget Inn Asakusa", hotel_type: "Budget Inn", star_rating: 2, price_per_night: 55, available_rooms: 48, amenities: "Free WiFi, Shared Kitchen, Luggage Storage, Friendly Staff", description: "Clean, friendly budget accommodation in historic Asakusa near Senso-ji Temple." },

  # Paris Hotels
  { destination: "Paris", name: "The Ritz Paris", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 1100, available_rooms: 8, amenities: "Michelin-Star Dining, Coco Chanel Suite, Legendary Bar, Spa Ritz, Indoor Pool, Butler Service", description: "The legendary palace hotel at Place Vendôme, setting the global benchmark for luxury since 1898." },
  { destination: "Paris", name: "Hôtel de Crillon", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 850, available_rooms: 10, amenities: "Rosewood Spa, Rooftop Terrasse, Les Ambassadeurs Restaurant, Piano Bar, Historic Grand Ballroom", description: "An 18th-century palace overlooking Place de la Concorde, reimagined as a contemporary palace." },
  { destination: "Paris", name: "Hôtel Saint-Louis Marais", hotel_type: "Boutique Hotel", star_rating: 3, price_per_night: 195, available_rooms: 22, amenities: "Free WiFi, Air Conditioning, Stone-Vaulted Breakfast Room, Historic Building", description: "Charming boutique hotel in the heart of Le Marais near the Pompidou Centre." },

  # Bali Hotels
  { destination: "Bali", name: "Four Seasons Bali at Sayan", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 780, available_rooms: 18, amenities: "Infinity Pool, Spa by the River, Yoga Pavilion, Butler Service, River-View Suites, Organic Dining", description: "Nestled in the lush jungle above the Ayung River in Ubud, one of Asia's most magical resorts." },
  { destination: "Bali", name: "Alaya Resort Ubud", hotel_type: "Boutique Hotel", star_rating: 4, price_per_night: 165, available_rooms: 28, amenities: "Infinity Pool, Balinese Spa, Rice Terrace View, Yoga Classes, Complimentary Breakfast", description: "Boutique resort with stunning rice terrace views and authentic Balinese architecture." },
  { destination: "Bali", name: "Kuta Beach Hostel", hotel_type: "Budget Inn", star_rating: 2, price_per_night: 28, available_rooms: 60, amenities: "Shared Pool, Free WiFi, Beach Access, Social Bar", description: "Lively budget accommodation steps from Kuta Beach, ideal for surf and backpacker culture." },

  # Rome Hotels
  { destination: "Rome", name: "Hotel Eden Rome", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 720, available_rooms: 10, amenities: "Rooftop Terrace with Panoramic Views, Il Giardino Restaurant, Spa, Valet Parking, City-Wide Concierge", description: "Lavish 5-star hotel on Via Ludovisi with commanding panoramas of Rome's iconic skyline." },
  { destination: "Rome", name: "Hotel Artemide", hotel_type: "Hotel", star_rating: 4, price_per_night: 220, available_rooms: 35, amenities: "Rooftop Pool, Free WiFi, Breakfast Included, Meeting Rooms, Via Nazionale Location", description: "Contemporary 4-star hotel on Rome's busiest street, walking distance to Termini station." },

  # Hunza Valley Hotels
  { destination: "Hunza Valley", name: "Eagle's Nest Hotel", hotel_type: "Boutique Hotel", star_rating: 4, price_per_night: 120, available_rooms: 20, amenities: "Mountain Panorama Views, Traditional Cuisine, Rakaposhi Sunrise Views, Trekking Guides", description: "Perched at 2,600m with unparalleled 360° Karakoram views, the crown jewel of Hunza hospitality." },
  { destination: "Hunza Valley", name: "Serena Hunza Hotel", hotel_type: "Hotel", star_rating: 3, price_per_night: 75, available_rooms: 30, amenities: "Mountain Views, Local Cuisine Restaurant, Traditional Architecture, Guided Tours, Free WiFi", description: "Comfortable mountain hotel set in a historic building with stunning Karakoram valley views." },

  # New York Hotels
  { destination: "New York City", name: "The Plaza Hotel", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 950, available_rooms: 15, amenities: "Central Park Views, Palm Court Restaurant, Champagne Bar, Full-Service Spa, Personal Shopping", description: "A National Historic Landmark at Fifth Avenue and Central Park South, the quintessential New York grand hotel." },
  { destination: "New York City", name: "Pod 51 Hotel", hotel_type: "Budget Inn", star_rating: 2, price_per_night: 89, available_rooms: 80, amenities: "Free WiFi, Rooftop Bar, Midtown Location, Luggage Storage, Apple TV in Rooms", description: "Smart, compact urban hotel in Midtown East, perfect for travelers who value location over space." },

  # Swiss Alps Hotels
  { destination: "Swiss Alps", name: "Victoria-Jungfrau Grand Hotel", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 890, available_rooms: 16, amenities: "Spa Nescens, Indoor Pool, Fine Dining, Ski-In Access, Jungfraujoch Views, Tennis Courts", description: "A magnificent Belle Époque palace hotel in Interlaken with direct Alpine panorama views." },
  { destination: "Swiss Alps", name: "Chalet Grindelwald", hotel_type: "Boutique Hotel", star_rating: 4, price_per_night: 340, available_rooms: 22, amenities: "Sauna & Hot Tub, Ski Storage, Mountain Views, Local Fondue Dinner, Hiking Packages", description: "Cozy Swiss chalet with stunning Eiger North Face views. Perfect for skiing and summer hiking." },

  # Dubai Hotels
  { destination: "Dubai", name: "Burj Al Arab Jumeirah", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 1800, available_rooms: 6, amenities: "Underwater Restaurant Al Mahara, Gold-Leaf Interiors, 24hr Butler, Private Beach, Helicopter Pad, 3 Pools", description: "The world's most photographed hotel, standing on its own island in a sail shape. The definition of ultra-luxury." },
  { destination: "Dubai", name: "Atlantis The Palm", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 650, available_rooms: 20, amenities: "Aquaventure Waterpark, The Lost Chambers Aquarium, 17 Restaurants, Spa, Private Beach", description: "Mega-resort on Palm Jumeirah with unparalleled entertainment and dining options." },

  # Barcelona Hotels
  { destination: "Barcelona", name: "W Barcelona", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 480, available_rooms: 14, amenities: "Infinity Pool, Eclipse Rooftop Bar, BLISS Spa, Beachfront Location, Spectacular Sea Views", description: "Striking sail-shaped tower on Barcelona's beachfront with some of the city's best panoramic views." },
  { destination: "Barcelona", name: "Hotel Arts Barcelona", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 520, available_rooms: 12, amenities: "Private Beach Club, Rooftop Pool, Six Sense Spa, Frank Gehry Fish Sculpture View, 4 Restaurants", description: "Ultra-modern skyscraper hotel by the sea with sweeping Mediterranean views." },

  # Maldives Hotels
  { destination: "Maldives", name: "Soneva Jani", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 2200, available_rooms: 8, amenities: "Overwater Villas, Retractable Roof for Stargazing, Private Pool, Observatory, Coral Reef Diving, Chef's Table", description: "The most magical resort in the Maldives — water villas with slide access to the lagoon and retractable roof to sleep under the stars." },
  { destination: "Maldives", name: "Baros Maldives", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 850, available_rooms: 12, amenities: "Lighthouse Restaurant over Water, Private Beach, Snorkeling, Turtle Point, Honeymoon Package", description: "An intimate private island resort combining authenticity, comfort, and world-class diving and snorkeling." },

  # Lahore Hotels
  { destination: "Lahore", name: "Pearl Continental Lahore", hotel_type: "Luxury Resort", star_rating: 5, price_per_night: 180, available_rooms: 25, amenities: "Multiple Restaurants, Indoor Pool, Business Centre, Spa, Traditional Music Evenings", description: "Lahore's premier 5-star hotel in the heart of the city's business and cultural district." },
  { destination: "Lahore", name: "Hotel Faletti's Lahore", hotel_type: "Hotel", star_rating: 4, price_per_night: 90, available_rooms: 40, amenities: "Historic Colonial Building, Garden Restaurant, Free WiFi, Close to Fort & Mosque", description: "Historic colonial hotel, established in 1880, retaining its old-world charm in the heart of Lahore." },
]

hotels_data.each do |h|
  dest = destinations[h[:destination]]
  next unless dest
  Hotel.create!(
    name: h[:name], destination: dest, hotel_type: h[:hotel_type],
    star_rating: h[:star_rating], price_per_night: h[:price_per_night],
    available_rooms: h[:available_rooms], amenities: h[:amenities],
    description: h[:description]
  )
end

puts "  📊 Total hotels: #{Hotel.count}"

# ==============================================================================
# TRANSPORTS
# ==============================================================================
puts "\n✈️  Creating transport routes..."

transport_data = [
  # International Flights
  { type: "Flight", origin: "London", dest_name: "Tokyo", dest: "Tokyo", provider: "Japan Airlines", fare: 780, duration: 690, departure: "10:30 AM", arrival: "08:45 AM+1", class: "Economy" },
  { type: "Flight", origin: "New York", dest_name: "Paris", dest: "Paris", provider: "Air France", fare: 620, duration: 420, departure: "07:15 PM", arrival: "08:45 AM+1", class: "Economy" },
  { type: "Flight", origin: "London", dest_name: "Bali", dest: "Bali", provider: "Emirates via Dubai", fare: 850, duration: 840, departure: "08:00 AM", arrival: "11:30 PM", class: "Economy" },
  { type: "Flight", origin: "Dubai", dest_name: "Maldives", dest: "Maldives", provider: "Emirates", fare: 320, duration: 240, departure: "09:15 AM", arrival: "01:45 PM", class: "Business" },
  { type: "Flight", origin: "London", dest_name: "New York City", dest: "New York City", provider: "British Airways", fare: 550, duration: 420, departure: "11:00 AM", arrival: "02:00 PM", class: "Economy" },
  { type: "Flight", origin: "Dubai", dest_name: "Barcelona", dest: "Barcelona", provider: "Flydubai", fare: 390, duration: 390, departure: "02:30 AM", arrival: "06:45 AM", class: "Economy" },
  { type: "Flight", origin: "London", dest_name: "Cape Town", dest: "Cape Town", provider: "British Airways", fare: 720, duration: 660, departure: "08:30 PM", arrival: "09:00 AM+1", class: "Economy" },
  { type: "Flight", origin: "Karachi", dest_name: "Dubai", dest: "Dubai", provider: "PIA", fare: 280, duration: 180, departure: "03:00 AM", arrival: "05:30 AM", class: "Economy" },
  { type: "Flight", origin: "Islamabad", dest_name: "Lahore", dest: "Lahore", provider: "Air Sial", fare: 45, duration: 55, departure: "08:00 AM", arrival: "09:00 AM", class: "Economy" },

  # International Trains
  { type: "Train", origin: "Paris", dest_name: "Barcelona", dest: "Barcelona", provider: "Renfe TGV High Speed", fare: 115, duration: 330, departure: "06:40 AM", arrival: "12:30 PM", class: "Standard" },
  { type: "Train", origin: "Paris", dest_name: "Rome", dest: "Rome", provider: "Thello Euronight", fare: 145, duration: 690, departure: "07:23 PM", arrival: "07:12 AM+1", class: "Business" },
  { type: "Train", origin: "Tokyo", dest_name: "Kyoto", dest: "Kyoto", provider: "JR Shinkansen Nozomi", fare: 85, duration: 135, departure: "09:00 AM", arrival: "11:15 AM", class: "Standard" },
  { type: "Train", origin: "Zurich", dest_name: "Swiss Alps", dest: "Swiss Alps", provider: "Swiss Federal Railways", fare: 65, duration: 120, departure: "08:32 AM", arrival: "10:32 AM", class: "Standard" },

  # Bus Routes
  { type: "Bus", origin: "Rome", dest_name: "Barcelona", dest: "Barcelona", provider: "FlixBus", fare: 48, duration: 1200, departure: "08:00 PM", arrival: "08:00 AM+1", class: "Economy" },
  { type: "Bus", origin: "Lahore", dest_name: "Swat Valley", dest: "Swat Valley", provider: "Daewoo Express", fare: 12, duration: 330, departure: "07:00 AM", arrival: "12:30 PM", class: "Economy" },

  # Pakistan Local Routes
  { type: "Car Rental", origin: "Islamabad", dest_name: "Hunza Valley", dest: "Hunza Valley", provider: "Karakoram Travels Self-Drive", fare: 95, duration: 510, departure: "06:00 AM", arrival: "02:30 PM", class: "Standard" },
  { type: "Car Rental", origin: "Islamabad", dest_name: "Swat Valley", dest: "Swat Valley", provider: "PTDC Self-Drive Package", fare: 65, duration: 240, departure: "07:00 AM", arrival: "11:00 AM", class: "Standard" },
  { type: "Car Rental", origin: "Lahore", dest_name: "Lahore", dest: "Lahore", provider: "City Car Rental", fare: 30, duration: 60, departure: "Any time", arrival: "As needed", class: "Economy" },

  # Car Rentals - International
  { type: "Car Rental", origin: "Nice Airport", dest_name: "Barcelona", dest: "Barcelona", provider: "Europcar", fare: 185, duration: 330, departure: "Flexible", arrival: "Flexible", class: "Standard" },
  { type: "Car Rental", origin: "Cape Town Airport", dest_name: "Cape Town", dest: "Cape Town", provider: "Avis South Africa", fare: 55, duration: 30, departure: "Flexible", arrival: "Flexible", class: "Economy" },

  # Private Transfers
  { type: "Private Transfer", origin: "Bali Airport", dest_name: "Bali", dest: "Bali", provider: "Bali Private Driver", fare: 35, duration: 60, departure: "On Arrival", arrival: "Hotel Door", class: "Standard" },
  { type: "Private Transfer", origin: "Dubai Airport", dest_name: "Dubai", dest: "Dubai", provider: "Dubai Chauffeur Services", fare: 75, duration: 45, departure: "On Arrival", arrival: "Hotel Door", class: "Business" },
]

transport_data.each do |t|
  dest = destinations[t[:dest]]
  Transport.create!(
    transport_type: t[:type], origin_city: t[:origin], destination_city: t[:dest_name],
    destination: dest, provider_name: t[:provider], fare_price: t[:fare],
    duration_minutes: t[:duration], departure_time: t[:departure], arrival_time: t[:arrival],
    comfort_class: t[:class], seats_available: rand(10..80)
  )
end

puts "  📊 Total transport routes: #{Transport.count}"

# ==============================================================================
# ROAD ROUTES / ROUTE INFO
# ==============================================================================
puts "\n🛣️  Creating road routes..."

routes_data = [
  { name: "Karakoram Highway — Islamabad to Hunza", origin: "Islamabad", dest_city: "Hunza", dest: "Hunza Valley", distance: 595, hours: 8.5, condition: "Good", tolls: 8, traffic: "Light", scenic: 5, highlights: "The KKH is one of the world's greatest road journeys. This engineering marvel hugs the Indus River gorge through Kohistan before climbing into the Karakoram. Expect mountain villages, glacier views, and stunning river crossings. Road conditions are generally good but mountain sections require care." },
  { name: "Islamabad to Swat — River Valley Route", origin: "Islamabad", dest_city: "Mingora", dest: "Swat Valley", distance: 255, hours: 4.5, condition: "Excellent", tolls: 4, traffic: "Moderate", scenic: 4, highlights: "Modern motorway from Islamabad to Nowshera, then scenic river valley highway through Mardan and Malakand into the Swat River valley. Beautiful emerald river views with snow-capped peaks ahead." },
  { name: "Lahore to Islamabad — Grand Trunk Road", origin: "Lahore", dest_city: "Islamabad", dest: "Lahore", distance: 380, hours: 4.0, condition: "Excellent", tolls: 6, traffic: "Moderate", scenic: 2, highlights: "The M-2 Motorway is Pakistan's premier road — 6-lane, fully maintained, with excellent rest areas at Kalar Kahar and Pindi Bhattian. Scenic Salt Range mountains in the middle section." },
  { name: "Paris to Barcelona — Mediterranean Coastal", origin: "Paris", dest_city: "Barcelona", dest: "Barcelona", distance: 1055, hours: 9.5, condition: "Excellent", tolls: 45, traffic: "Moderate", scenic: 5, highlights: "A superb drive through southern France on the A9 Autoroute passing Montpellier, Narbonne, and the stunning Pyrenees foothills before crossing into Spain. Coastal Languedoc views and vineyards make this a truly scenic road trip." },
  { name: "Rome to Florence — Via A1 Autostrade", origin: "Rome", dest_city: "Florence", dest: "Rome", distance: 280, hours: 3.0, condition: "Excellent", tolls: 18, traffic: "Moderate", scenic: 3, highlights: "The A1 'Autostrada del Sole' connects Rome and Florence via the scenic Apennines mountain spine of Italy. Pass Orvieto's clifftop cathedral and Valdichiana before descending into the Arno valley toward Florence." },
  { name: "Cape Town to Cape of Good Hope", origin: "Cape Town", dest_city: "Cape Point", dest: "Cape Town", distance: 70, hours: 1.5, condition: "Good", tolls: 0, traffic: "Light", scenic: 5, highlights: "One of the world's most spectacular coastal drives along Chapman's Peak with dramatic Atlantic Ocean cliffs. Past Hout Bay fishing village, Noordhoek Beach, and through Table Mountain National Park to Cape Point." },
  { name: "Interlaken to Jungfraujoch Base", origin: "Interlaken", dest_city: "Grindelwald", dest: "Swiss Alps", distance: 22, hours: 0.5, condition: "Good", tolls: 0, traffic: "Light", scenic: 5, highlights: "A short but magnificent drive from Interlaken to Grindelwald, with the Eiger North Face dominating the skyline ahead. Pristine Swiss villages, lush meadows, and Alpine flowers line the route." },
  { name: "Dubai City Loop — Sheikh Zayed Road", origin: "Dubai Airport", dest_city: "Palm Jumeirah", dest: "Dubai", distance: 35, hours: 0.75, condition: "Excellent", tolls: 2, traffic: "Heavy", scenic: 4, highlights: "Sheikh Zayed Road is Dubai's backbone expressway flanked by the world's most futuristic skyline. Salik tolls apply. Traffic peaks 8-10am and 5-8pm. The Palm Jumeirah off-ramp offers stunning waterfront approach views." },
]

routes_data.each do |r|
  dest = destinations[r[:dest]]
  RoutesInfo.create!(
    route_name: r[:name], origin_city: r[:origin], destination_city: r[:dest_city],
    destination: dest, distance_km: r[:distance], estimated_drive_time_hours: r[:hours],
    road_condition: r[:condition], toll_charges: r[:tolls], traffic_level: r[:traffic],
    scenic_score: r[:scenic], route_highlights: r[:highlights]
  )
end

puts "  📊 Total road routes: #{RoutesInfo.count}"

# ==============================================================================
# WEATHER FORECASTS
# ==============================================================================
puts "\n🌦️  Creating weather forecasts..."

weather_scenarios = {
  "Tokyo" => [
    { condition: "Partly Cloudy", temp: 18, rain: 15, wind: 12, humidity: 55 },
    { condition: "Sunny", temp: 22, rain: 5, wind: 8, humidity: 48 },
    { condition: "Light Rain", temp: 15, rain: 70, wind: 18, humidity: 78 },
    { condition: "Clear Sky", temp: 20, rain: 8, wind: 10, humidity: 52 },
    { condition: "Overcast", temp: 16, rain: 40, wind: 14, humidity: 68 },
    { condition: "Sunny", temp: 24, rain: 3, wind: 7, humidity: 45 },
    { condition: "Partly Cloudy", temp: 19, rain: 20, wind: 11, humidity: 58 },
  ],
  "Paris" => [
    { condition: "Cloudy", temp: 16, rain: 45, wind: 20, humidity: 72 },
    { condition: "Light Rain", temp: 13, rain: 80, wind: 25, humidity: 85 },
    { condition: "Partly Cloudy", temp: 18, rain: 30, wind: 15, humidity: 65 },
    { condition: "Sunny", temp: 22, rain: 5, wind: 10, humidity: 50 },
    { condition: "Clear Sky", temp: 21, rain: 8, wind: 12, humidity: 55 },
    { condition: "Overcast", temp: 14, rain: 55, wind: 22, humidity: 78 },
    { condition: "Sunny", temp: 23, rain: 10, wind: 9, humidity: 48 },
  ],
  "Bali" => [
    { condition: "Tropical Sunshine", temp: 30, rain: 10, wind: 8, humidity: 75 },
    { condition: "Partly Cloudy", temp: 28, rain: 20, wind: 10, humidity: 80 },
    { condition: "Afternoon Shower", temp: 29, rain: 65, wind: 15, humidity: 85 },
    { condition: "Tropical Sunshine", temp: 31, rain: 5, wind: 7, humidity: 72 },
    { condition: "Clear Sky", temp: 30, rain: 3, wind: 8, humidity: 70 },
    { condition: "Partly Cloudy", temp: 28, rain: 25, wind: 12, humidity: 78 },
    { condition: "Tropical Sunshine", temp: 31, rain: 8, wind: 9, humidity: 74 },
  ],
  "Dubai" => [
    { condition: "Sunny & Hot", temp: 38, rain: 2, wind: 15, humidity: 45 },
    { condition: "Sunny & Hot", temp: 40, rain: 0, wind: 12, humidity: 40 },
    { condition: "Partly Cloudy", temp: 36, rain: 5, wind: 18, humidity: 50 },
    { condition: "Sunny & Hot", temp: 39, rain: 0, wind: 10, humidity: 42 },
    { condition: "Clear Sky", temp: 37, rain: 2, wind: 14, humidity: 46 },
    { condition: "Sunny & Hot", temp: 41, rain: 0, wind: 16, humidity: 38 },
    { condition: "Partly Cloudy", temp: 35, rain: 3, wind: 20, humidity: 52 },
  ],
  "Hunza Valley" => [
    { condition: "Sunny Mountain", temp: 22, rain: 8, wind: 10, humidity: 40 },
    { condition: "Clear Sky", temp: 25, rain: 5, wind: 8, humidity: 35 },
    { condition: "Partly Cloudy", temp: 20, rain: 15, wind: 12, humidity: 48 },
    { condition: "Snow Flurry", temp: 5, rain: 60, wind: 20, humidity: 65 },
    { condition: "Sunny Mountain", temp: 23, rain: 5, wind: 9, humidity: 38 },
    { condition: "Clear Sky", temp: 26, rain: 3, wind: 7, humidity: 33 },
    { condition: "Partly Cloudy", temp: 18, rain: 20, wind: 15, humidity: 52 },
  ],
}

# Default forecast for all other destinations
default_forecasts = [
  { condition: "Partly Cloudy", temp: 22, rain: 25, wind: 12, humidity: 60 },
  { condition: "Sunny", temp: 26, rain: 8, wind: 8, humidity: 52 },
  { condition: "Clear Sky", temp: 24, rain: 5, wind: 10, humidity: 48 },
  { condition: "Light Rain", temp: 18, rain: 65, wind: 18, humidity: 80 },
  { condition: "Partly Cloudy", temp: 21, rain: 30, wind: 14, humidity: 65 },
  { condition: "Sunny", temp: 25, rain: 10, wind: 9, humidity: 55 },
  { condition: "Overcast", temp: 19, rain: 40, wind: 16, humidity: 70 },
]

Destination.all.each do |dest|
  scenarios = weather_scenarios[dest.name] || default_forecasts
  scenarios.each_with_index do |w, i|
    WeatherForecast.create!(
      destination: dest,
      forecast_date: Date.today + i,
      condition: w[:condition],
      temperature_celsius: w[:temp],
      rainfall_prob: w[:rain],
      wind_speed_kmh: w[:wind],
      humidity: w[:humidity],
      travel_guidance: "Pack layers and comfortable walking shoes. #{w[:rain] > 50 ? 'Rain gear essential.' : 'Sunscreen recommended.'}"
    )
  end
end

puts "  📊 Total weather forecasts: #{WeatherForecast.count}"

# ==============================================================================
# CROWD FORECASTS
# ==============================================================================
puts "\n👥 Creating crowd forecasts..."

crowd_data_by_dest = {
  "Tokyo" => [
    { month: "January-February (Winter)", season: "Low Season", level: "Low", intensity: 35, occupancy: 52, recommendations: "Excellent time — shorter queues at temples and museums. Cold but manageable. Great hotel deals available." },
    { month: "March-May (Cherry Blossom)", season: "Peak Season", level: "High", intensity: 95, occupancy: 98, recommendations: "Sakura season is Tokyo's absolute peak. Book everything 6+ months ahead. Ueno Park and Shinjuku Gyoen extremely crowded." },
    { month: "June-August (Summer)", season: "Shoulder Season", level: "Medium", intensity: 62, occupancy: 75, recommendations: "Hot and humid but manageable. School holidays bring domestic visitors. Good availability for international travelers." },
    { month: "September-November (Autumn)", season: "Peak Season", level: "High", intensity: 88, occupancy: 90, recommendations: "Autumn foliage season is nearly as popular as cherry blossoms. Book 3-4 months ahead. Outstanding colors in Nikko and Kyoto." },
  ],
  "Paris" => [
    { month: "January-February (Winter)", season: "Low Season", level: "Low", intensity: 28, occupancy: 42, recommendations: "Paris at its most Parisian — fewer tourists, authentic café culture. Some museums have shorter hours. Great fashion week deals." },
    { month: "June-August (Summer)", season: "Peak Season", level: "High", intensity: 92, occupancy: 97, recommendations: "Paris is overwhelmingly busy in summer. Expect 2-3 hour queues at the Eiffel Tower and Louvre without advance tickets. Book EVERYTHING ahead." },
    { month: "April-May (Spring)", season: "Shoulder Season", level: "Medium", intensity: 68, occupancy: 78, recommendations: "Spring is Paris at its most romantic. Manageable crowds, beautiful blooms. Book Louvre and Eiffel Tower tickets 2 weeks ahead." },
    { month: "September-October (Early Autumn)", season: "Shoulder Season", level: "Medium", intensity: 58, occupancy: 70, recommendations: "The savvy traveler's season — post-summer calm with beautiful autumn light. Most attractions open fully. Excellent value." },
  ],
  "Bali" => [
    { month: "July-August (Dry Season Peak)", season: "Peak Season", level: "High", intensity: 89, occupancy: 95, recommendations: "Australian and European summer holidays flood Bali. Seminyak and Kuta very crowded. Ubud rice terraces jammed. Book 3 months ahead." },
    { month: "April-June (Dry Season Start)", season: "Shoulder Season", level: "Medium", intensity: 55, occupancy: 68, recommendations: "Perfect time to visit — great weather beginning, manageable crowds. Explore off-the-beaten temples and villages with ease." },
    { month: "January-March (Wet Season)", season: "Low Season", level: "Low", intensity: 25, occupancy: 38, recommendations: "Rainy season brings lush green landscapes and heavily discounted hotels. Short intense showers, not all-day rain. Excellent deals." },
    { month: "September-November", season: "Shoulder Season", level: "Medium", intensity: 48, occupancy: 62, recommendations: "Transition season with very manageable tourism. Good balance of dry weather and reasonable pricing. Nyepi Day in March is magical." },
  ],
  "Hunza Valley" => [
    { month: "March-April (Cherry Blossom)", season: "Peak Season", level: "High", intensity: 80, occupancy: 92, recommendations: "Hunza's most spectacular time — apricot and cherry blossom carpet the valley. Very limited accommodation, book 4 months ahead." },
    { month: "May-September (Summer)", season: "Peak Season", level: "High", intensity: 75, occupancy: 85, recommendations: "Main trekking and touring season. Khunjerab Pass open. Book Eagle's Nest and good hotels 2-3 months ahead." },
    { month: "October-November (Autumn)", season: "Shoulder Season", level: "Medium", intensity: 42, occupancy: 55, recommendations: "Golden harvest season with beautiful autumn colors. Fewer tourists than summer but weather still decent. Good value." },
    { month: "December-February (Winter)", season: "Low Season", level: "Low", intensity: 12, occupancy: 20, recommendations: "Very few visitors — Khunjerab Pass closed. Cold but the valley under snow is hauntingly beautiful. Limited hotels open." },
  ],
}

default_crowd = [
  { month: "January-March", season: "Low Season", level: "Low", intensity: 30, occupancy: 45, recommendations: "Low season offers best hotel rates and shortest queues. Ideal for budget-conscious travelers." },
  { month: "April-June", season: "Shoulder Season", level: "Medium", intensity: 58, occupancy: 70, recommendations: "Good balance of weather, crowds, and cost. Most attractions are accessible without long waits." },
  { month: "July-August", season: "Peak Season", level: "High", intensity: 88, occupancy: 94, recommendations: "Peak summer season — very busy and expensive. Book all accommodation and major attractions well in advance." },
  { month: "September-December", season: "Shoulder Season", level: "Medium", intensity: 50, occupancy: 65, recommendations: "Autumn offers excellent value with fewer crowds and beautiful seasonal colors. Highly recommended." },
]

Destination.all.each do |dest|
  crowd_items = crowd_data_by_dest[dest.name] || default_crowd
  crowd_items.each do |c|
    CrowdForecast.create!(
      destination: dest,
      month_or_season: c[:month],
      season_type: c[:season],
      crowd_level: c[:level],
      intensity_percentage: c[:intensity],
      average_hotel_occupancy: c[:occupancy],
      recommendations: c[:recommendations]
    )
  end
end

puts "  📊 Total crowd forecasts: #{CrowdForecast.count}"

# ==============================================================================
# ALERTS
# ==============================================================================
puts "\n🔔 Creating initial system alerts..."

Alert.create!([
  {
    alert_type: "Weather",
    title: "Monsoon Advisory — Bali, Indonesia",
    message: "Seasonal monsoon activity is generating afternoon thunderstorms across Bali. Rain is typically short and intense (30-90 mins). Carry a compact rain jacket, avoid cliff edge viewpoints during storms, and reschedule outdoor activities to mornings. Water activities at Seminyak and Nusa Dua may be suspended during red flag conditions.",
    severity: "warning",
    destination: destinations["Bali"],
    is_read: false
  },
  {
    alert_type: "Safety",
    title: "Cherry Blossom Season Crowd Alert — Tokyo & Kyoto",
    message: "March-April sakura season brings extreme visitor density to Tokyo's Ueno Park, Shinjuku Gyoen, and Kyoto's Philosopher's Path. Expect 2-4 hour waits at top viewpoints on weekends. Pre-book all restaurant reservations. The Shinkansen between Tokyo and Kyoto is often fully booked — purchase JR Pass before departure.",
    severity: "info",
    destination: destinations["Tokyo"],
    is_read: false
  },
  {
    alert_type: "Travel Advisory",
    title: "Hunza Valley — Khunjerab Pass Season Opening",
    message: "The Khunjerab Pass (4,693m, world's highest paved international border) opens annually in May for the summer season. Vehicle convoys operate on scheduled days. Ensure your vehicle is properly serviced for high-altitude driving, carry sufficient fuel from Gilgit, and check NATCO bus availability for non-drivers.",
    severity: "info",
    destination: destinations["Hunza Valley"],
    is_read: false
  },
  {
    alert_type: "Route Closure",
    title: "Summer Heatwave Advisory — Dubai",
    message: "Dubai is experiencing exceptional heat (42-45°C) this week. Outdoor sightseeing is recommended only before 10 AM and after 5 PM. The desert safari operates with modified schedules — sunset departures only. Ensure comprehensive sun protection, stay hydrated, and use air-conditioned transport between attractions.",
    severity: "warning",
    destination: destinations["Dubai"],
    is_read: false
  },
  {
    alert_type: "System",
    title: "Welcome to TravelMaster!",
    message: "Your smart travel planning platform is ready. Explore 15+ world-class destinations, build detailed itineraries, get AI-powered cost estimates, and access real-time weather and crowd intelligence. Start planning your next adventure from the Destinations page!",
    severity: "info",
    destination: nil,
    is_read: false
  }
])

puts "  📊 Total alerts: #{Alert.count}"

# ==============================================================================
# SAMPLE TRIPS
# ==============================================================================
puts "\n🗺️  Creating sample trips..."

tokyo_dest = destinations["Tokyo"]
kyoto_dest = destinations["Kyoto"]
bali_dest = destinations["Bali"]
paris_dest = destinations["Paris"]
hunza_dest = destinations["Hunza Valley"]

trip1 = Trip.create!(
  user: traveler,
  title: "Japan Cherry Blossom Adventure",
  notes: "A 14-day immersive journey through Japan's most iconic destinations during sakura season. From the ultra-modern streets of Tokyo to the ancient temples of Kyoto, this trip captures the best of traditional and contemporary Japan.",
  start_date: Date.today + 30,
  end_date: Date.today + 44,
  number_of_travelers: 2,
  total_estimated_cost: 0,
  target_budget: 7000
)

TripDestination.create!(trip: trip1, destination: tokyo_dest, visit_order: 1, stay_days: 7)
TripDestination.create!(trip: trip1, destination: kyoto_dest, visit_order: 2, stay_days: 5)

# Auto-estimate costs for trip1
est1 = CostEstimationService.estimate(destinations: trip1.destinations, duration_days: trip1.duration_days, travelers: trip1.number_of_travelers, travel_tier: traveler.travel_preference || "moderate")
CostEstimationService.populate_trip_bookings_from_estimate(trip1, est1)

trip2 = Trip.create!(
  user: traveler,
  title: "Bali Spiritual Retreat & Beach Escape",
  notes: "10 days of wellness, culture, and paradise beaches in the Island of Gods. Ubud yoga sessions, temple explorations, and Seminyak sunset cocktails.",
  start_date: Date.today + 60,
  end_date: Date.today + 70,
  number_of_travelers: 1,
  total_estimated_cost: 0,
  target_budget: 3000
)

TripDestination.create!(trip: trip2, destination: bali_dest, visit_order: 1, stay_days: 9)
est2 = CostEstimationService.estimate(destinations: trip2.destinations, duration_days: trip2.duration_days, travelers: trip2.number_of_travelers, travel_tier: "moderate")
CostEstimationService.populate_trip_bookings_from_estimate(trip2, est2)

trip3 = Trip.create!(
  user: traveler,
  title: "Romantic Paris & Barcelona Getaway",
  notes: "Two of Europe's most beautiful cities in one perfectly crafted 10-day itinerary. Eiffel Tower dinners, Gaudí architecture, Mediterranean beaches, and world-class cuisine throughout.",
  start_date: Date.today + 90,
  end_date: Date.today + 100,
  number_of_travelers: 2,
  total_estimated_cost: 0,
  target_budget: 9000
)

TripDestination.create!(trip: trip3, destination: paris_dest, visit_order: 1, stay_days: 5)
TripDestination.create!(trip: trip3, destination: destinations["Barcelona"], visit_order: 2, stay_days: 4)
est3 = CostEstimationService.estimate(destinations: trip3.destinations, duration_days: trip3.duration_days, travelers: trip3.number_of_travelers, travel_tier: "moderate")
CostEstimationService.populate_trip_bookings_from_estimate(trip3, est3)

trip4 = Trip.create!(
  user: traveler,
  title: "Karakoram Mountains Discovery — Hunza & Swat",
  notes: "Pakistan's most spectacular mountain journey through the legendary Karakoram Highway to Hunza Valley and the verdant Swat Valley. Ancient forts, glacier lakes, and the warmest hospitality in the world.",
  start_date: Date.today + 14,
  end_date: Date.today + 22,
  number_of_travelers: 3,
  total_estimated_cost: 0,
  target_budget: 1500
)

TripDestination.create!(trip: trip4, destination: hunza_dest, visit_order: 1, stay_days: 5)
TripDestination.create!(trip: trip4, destination: destinations["Swat Valley"], visit_order: 2, stay_days: 3)
est4 = CostEstimationService.estimate(destinations: trip4.destinations, duration_days: trip4.duration_days, travelers: trip4.number_of_travelers, travel_tier: "budget")
CostEstimationService.populate_trip_bookings_from_estimate(trip4, est4)

puts "  📊 Total trips: #{Trip.count}"
puts "  📊 Total trip bookings: #{TripBooking.count}"

# ==============================================================================
# SUMMARY
# ==============================================================================
puts "\n" + "=" * 60
puts "🎉 TravelMaster database seeded successfully!"
puts "=" * 60
puts ""
puts "📊 ENTITY COUNTS:"
puts "   👤 Users:             #{User.count} (admin + traveler)"
puts "   📍 Destinations:      #{Destination.count}"
puts "   🏨 Hotels:            #{Hotel.count}"
puts "   ✈️  Transports:        #{Transport.count}"
puts "   🛣️  Road Routes:       #{RoutesInfo.count}"
puts "   🌦️  Weather Forecasts: #{WeatherForecast.count}"
puts "   👥 Crowd Forecasts:   #{CrowdForecast.count}"
puts "   🔔 Alerts:            #{Alert.count}"
puts "   🗺️  Trips:             #{Trip.count}"
puts "   💳 Bookings:          #{TripBooking.count}"
puts ""
puts "🔐 DEMO LOGIN CREDENTIALS:"
puts "   Admin:    admin@travelmaster.com    / password123"
puts "   Traveler: traveler@travelmaster.com / password123"
puts ""
puts "🚀 Run 'ruby bin/rails server' and visit http://localhost:3000"
puts "=" * 60

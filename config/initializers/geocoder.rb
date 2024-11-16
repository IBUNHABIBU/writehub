Geocoder.configure(
    timeout: 5,
    lookup: google,
    api_key: ENV['GOOGLE_API'],
    ip_lookup: :ipinfo_io,    
    units: :km,              
    http_headers: { 'Referer' => 'https://writehub.cyou' }
)
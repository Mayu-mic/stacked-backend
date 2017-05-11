Rails.application.config.middleware.use OmniAuth::Builder do
    API_KEY = '36233715831.182278718966'
    API_SECRET = '2200b6c1e6060d4d2beb0e744a395302'
    provider :slack, API_KEY, API_SECRET, scope: 'identity.basic'
end
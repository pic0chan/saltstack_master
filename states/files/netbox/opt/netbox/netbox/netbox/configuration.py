ALLOWED_HOSTS = [{{ hostlist|join(', ') }}]
DATABASE = {
    'NAME': 'netbox',         # Database name
    'USER': 'netbox',               # PostgreSQL username
    'PASSWORD': 'netbox',           # PostgreSQL password
    'HOST': 'localhost',      # Database server
    'PORT': '',               # Database port (leave blank for default)
}
SECRET_KEY = '1SM+6t-F&vI7WEvQC0DL@e0aix-kVOySAnMo0u#CUmia1u#E2I'
ADMINS = [
    ['sakai-yasu', 'pico_yasu_99_2@yahoo.co.jp'],
]
EMAIL = {
    'SERVER': 'localhost',
    'PORT': 25,
    'USERNAME': 'sakai-yasu',
    'PASSWORD': 'netbox',
    'TIMEOUT': 10,  # seconds
    'FROM_EMAIL': 'netbox@sakai-yasu.local',
}
LOGIN_REQUIRED = False
BASE_PATH = ''
MAINTENANCE_MODE = False
NETBOX_USERNAME = ''
#NETBOX_USERNAME = 'sakai-yasu'
NETBOX_PASSWORD = ''
#NETBOX_PASSWORD = 'netbox'
PAGINATE_COUNT = 50
TIME_ZONE = 'UTC'
DATE_FORMAT = 'N j, Y'
SHORT_DATE_FORMAT = 'Y-m-d'
TIME_FORMAT = 'g:i a'
SHORT_TIME_FORMAT = 'H:i:s'
DATETIME_FORMAT = 'N j, Y g:i a'
SHORT_DATETIME_FORMAT = 'Y-m-d H:i'
BANNER_TOP = ''
BANNER_BOTTOM = ''
PREFER_IPV4 = False
ENFORCE_GLOBAL_UNIQUE = False

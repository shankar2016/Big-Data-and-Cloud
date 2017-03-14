import object_storage
import pprint

# Declare username, apikey and datacenter
USERNAME = 'SL1187161'
API_KEY = '3d2ff55990eacb6b652bbe638b7e38fc30ee6f3f226eba1ca83fe5d1e1e4051f'
DATACENTER = 'https://dal05.objectstorage.service.networklayer.com/auth/v1.0/'
# Creating object storage connection
sl_storage = object_storage.get_httplib2_client(USERNAME, API_KEY, auth_url=DATACENTER)
# Declare name to filter
name = 'icm10restapi-qa.zip'

# Filtering
containers = sl_storage.search(name)
print(containers)

#for container in containers['results']:
    #if container.__dict__['name'].startswith(name):
        #print(container)

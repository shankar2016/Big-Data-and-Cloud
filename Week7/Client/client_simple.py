import object_storage

USERNAME = 'SL1187161'


API_KEY = '3d2ff55990eacb6b652bbe638b7e38fc30ee6f3f226eba1ca83fe5d1e1e4051f'
DATACENTER = 'https://dal05.objectstorage.service.networklayer.com/auth/v1.0/'
#DATACENTER = 'dal05'

#sl_storage = object_storage.get_client('SL1187161', '3d2ff55990eacb6b652bbe638b7e38fc30ee6f3f226eba1ca83fe5d1e1e4051f', auth_url=DATACENTER)
sl_storage = object_storage.get_client('SLOS1187161-3:SL1187161', '3d2ff55990eacb6b652bbe638b7e38fc30ee6f3f226eba1ca83fe5d1e1e4051f', datacenter='dal05')

print(sl_storage)


containers = sl_storage.containers()
print(containers)


create_status = sl_storage['test.txt'].create()
print(create_status)


delete_status = sl_storage['test.txt'].delete()
print(delete_status)

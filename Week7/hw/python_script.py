import object_storage
import swiftclient

# My username
USERNAME = 'SL1187161'

# My API key
API_KEY = '3d2ff55990eacb6b652bbe638b7e38fc30ee6f3f226eba1ca83fe5d1e1e4051f'
DATACENTER = 'https://dal05.objectstorage.service.networklayer.com/auth/v1.0/'
#DATACENTER = 'dal05'

# Connect to Object Store
sl_storage = object_storage.get_client('SLOS1187161-3:SL1187161', '3d2ff55990eacb6b652bbe638b7e38fc30ee6f3f226eba1ca83fe5d1e1e4051f', datacenter='dal05')

# ensure that connect to object store worked
print("SL Object Store Connected {}".format(sl_storage))


# List the containers that exist
containers = sl_storage.containers()
print("SL Object Store Containers {}".format(containers))

# Add an object to the store
create_status = sl_storage['test.txt'].create()
print("SL Object Store Create status is {}".format(create_status))
create_status = sl_storage['container1']['testfile.txt'].create()
print("SL Object Store Create status is {}".format(create_status))

#sl_storage['container1']['textfile.txt'].send('Plain-Text Content')
swift_conn = swiftclient.Connection(user='SLOS1187161-3:SL1187161',
                        key='3d2ff55990eacb6b652bbe638b7e38fc30ee6f3f226eba1ca83fe5d1e1e4051f',
                         authurl='https://dal05.objectstorage.service.networklayer.com/auth/v1.0')
print("SL Object Store switft conn is {}".format(swift_conn))
file_name = "junk.txt"
with open(file_name, 'r') as upload_file:
        swift_conn.put_object('container1', 'junk.txt', contents= upload_file.read())
#sl_storage['container1']['textfile.txt'].put()

# List the objects to ensure that object got added
print("Assignments asks that we list the data")
list_status = sl_storage['container1'].objects()
print("SL Object Store List status is {}".format(list_status))

# Delete one object
print("Assignments asks that we delete an object")
delete_status = sl_storage['test.txt'].delete()
delete_status = sl_storage['container1']['testfile.txt'].delete()
print("SL Object Store Delete status is {}".format(delete_status))

# ensure that delete worked
list_status = sl_storage['container1'].objects()
print("SL Object Store FINAL List status is {}".format(list_status))

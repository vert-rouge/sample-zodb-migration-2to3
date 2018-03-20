# -*- coding: utf-8 -*-

import ZODB, ZODB.FileStorage

storage = ZODB.FileStorage.FileStorage('Data_python2.fs')
db = ZODB.DB(storage)

with db.transaction() as connection:
    print("la transaction est ouverte!")
    print(connection.root.truc)
    print(dir(connection.root.truc))

    for k,v in connection.root.truc.items():
        print(k)
        print(v)

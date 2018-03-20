# -*- coding: utf-8 -*-

import ZODB, ZODB.FileStorage
from BTrees.OOBTree import OOBTree
import uuid

storage = ZODB.FileStorage.FileStorage('Data_python2.fs')
db = ZODB.DB(storage)

with db.transaction() as connection:
    connection.root.truc = OOBTree()
    for i in range(1000):
        ti = OOBTree()
        ti[str(uuid.uuid4())] = "MWAHAHAHA" + str(i)
        connection.root.truc[str(uuid.uuid4())] = ti


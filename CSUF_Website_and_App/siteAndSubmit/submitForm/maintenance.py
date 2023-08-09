# Name: Yuval Noiman
# Date: 2/15/2023
# File Purpose: SQL Connection
from mysql.connector import connect, Error

class Maintenance:
  
  def __init__(self, /):
    #declares database file
    self.database = "maintenance"

  def add_personal(self, FirstName, LastName, CWID, PhoneNumber, Email, passkey, /):
    #adds contact
    try:
      with connect(
        host="localhost",
        user="root",
        password="EnterYourPassword",
        database="maintenance",
      ) as con:
        with con.cursor() as cur:
          cur.execute("INSERT INTO PersonalInfo (FirstName, LastName, CWID, PhoneNumber, Email, Pass) VALUES (%s, %s, %s, %s, %s, %s)", (FirstName, LastName, CWID, PhoneNumber, Email, passkey))
          con.commit()
    except Error as e:
      print(e)
    con.close()

  def login(self, email, passkey ,/):
    try:
      with connect(
        host="localhost",
        user="root",
        password="EnterYourPassword",
        database="maintenance",
      ) as con:
        with con.cursor() as cur:
            command = ("Select EMAIL, PASS, CWID from PersonalInfo where Email = '"+ email +"'")
            cur.execute(command)
            result = cur.fetchall()
            if (len(result) <1):
              return (-1)
            if (passkey == result[0][1]):
              return result[0][2]
            else:
              return (0)
    except Error as e:
      print(e)
    con.close()


  def get_Pass(self, email,/):
    try:
      with connect(
        host="localhost",
        user="root",
        password="EnterYourPassword",
        database="maintenance",
      ) as con:
        with con.cursor() as cur:
            command = ("Select PASS from PersonalInfo where Email = '"+ email +"'")
            cur.execute(command)
            result = cur.fetchall()
            if (len(result) <1):
              return (-1)
            else:
              return result[0][0]
    except Error as e:
      print(e)
    con.close()



  def add_locational(self, CWID, Location, Descript, Category, Emergency, /):
    #adds phone
    try:
      with connect(
        host="localhost",
        user="root",
        password="EnterYourPassword",
        database="maintenance",
      ) as con:
        with con.cursor() as cur:
          cur.execute("INSERT INTO RequestInfo (ID, Location, Descript, Category, Emergency) VALUES (%s, %s, %s, %s, %s)", (CWID, Location, Descript, Category, Emergency))
          con.commit()
    except Error as e:
      print(e)
    con.close()

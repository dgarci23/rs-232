import serial

ser = serial.Serial("COM11", baudrate=9600)

index = 1

while True:
    print(ser.read())
    print("Index {}".format(index))
    index += 1


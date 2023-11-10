import socket


def start_server():
    server_ip = '0.0.0.0'  # Listen on all available network interfaces
    server_port = 12345    # Use the same port as in the Dart client example

    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((server_ip, server_port))
    server_socket.listen(1)  # Number of connections to queue

    print(f"Server listening on {server_ip}:{server_port}")

    while True:
        client_socket, client_address = server_socket.accept()
        print(f"Accepted connection from {client_address}")

        data = client_socket.recv(1024).decode()  # Receive data from client
        print(f"Received message: {data}")

        client_socket.close()


if __name__ == "__main__":
    start_server()

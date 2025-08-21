#pragma once

#include <iostream>

struct Server
{
private:
	char IPAddress[5];
	char* OS;
	unsigned memory;
	unsigned RAM;
	double CPU;

	bool strcmp(const char* checkThis, size_t strLengthWhat, const char* compareWithThis, size_t strLenCompared) const;


public:
	Server();
	~Server();
	void read();
	bool operator==(const Server& other) const;
	void print() const;
	bool Server::operator<(const Server &other) const;
	/*
	*/

};
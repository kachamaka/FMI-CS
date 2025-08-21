#ifndef QUEUE_H
#define QUEUE_H

#include "queue.hpp" // hpp or cpp

class Queue {
private:
    int size;

public:
    Queue(int size);

    int getTicket(const char* name, const char* phone);

    unsigned operator[](const Ticket& obj);

    Ticket next();

    bool empty() const;
    int getSize() const;
};

#endif
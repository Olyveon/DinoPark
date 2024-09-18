#ifndef LINKEDLIST_HPP
#define LINKEDLIST_HPP

#include <iostream>
#include <stdexcept>

template<typename T>
class Nodo {
public:
    T data;
    Nodo* next;
    Nodo(T value) : data(value), next(nullptr) {}
};

template<typename T>
class LinkedList {
private:
    Nodo<T>* head;
    size_t size;

public:
    LinkedList() : head(nullptr), size(0) {}

    ~LinkedList() {
        while (head != nullptr) {
            Nodo<T>* temp = head;
            head = head->next;
            delete temp;
        }
    }

    void appendValue(T value) {
        Nodo<T>* newNode = new Nodo<T>(value);
        if (head == nullptr) {
            head = newNode;
        }
        else {
            Nodo<T>* current = head;
            while (current->next != nullptr) {
                current = current->next;
            }
            current->next = newNode;
        }
        size++;
    }

    void prependValue(T value) {
        Nodo<T>* newNode = new Nodo<T>(value);
        newNode->next = head;
        head = newNode;
        size++;
    }

    void removeValue(T value) {
        if (head == nullptr) {
            return;
        }

        if (head->data == value) {
            Nodo<T>* temp = head;
            head = head->next;
            delete temp;
            size--;
            return;
        }

        Nodo<T>* current = head;
        while (current->next != nullptr && current->next->data != value) {
            current = current->next;
        }

        if (current->next != nullptr) {
            Nodo<T>* temp = current->next;
            current->next = current->next->next;
            delete temp;
            size--;
        }
    }

    bool contains(T value) const {
        Nodo<T>* current = head;
        while (current != nullptr) {
            if (current->data == value) {
                return true;
            }
            current = current->next;
        }
        return false;
    }

    T getValue(int index) const {
        if (index < 0 || index >= size) {
            throw std::out_of_range("Index out of bounds");
        }

        Nodo<T>* current = head;
        for (int i = 0; i < index; ++i) {
            current = current->next;
        }
        return current->data;
    }

    size_t getSize() const {
        return size;
    }
};

#endif

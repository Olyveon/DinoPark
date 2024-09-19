#ifndef CUSTOM_LIST_H
#define CUSTOM_LIST_H

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/variant/utility_functions.hpp>
#include "LinkedList.hpp"

using namespace godot;

class CustomList : public Node {
    GDCLASS(CustomList, Node); // Creates a new Godot Class that inherits Node

private:
    LinkedList<int> data; // Intial list with int as its data type

protected:
    static void _bind_methods(); // Method bindings for Godot

public:
    CustomList(); // Constructor
    ~CustomList(); // Destructor

    void append(const Variant& value); // Add an element at the end of the list
    void prepend(const Variant& value); // Add an element at the beginning of the list
    bool contains(const Variant& value); // Checks if the list contains a node with the specified value
    Variant get(int index) const; // Get an element
    void remove(const Variant& value); // Remove an element
    int size() const; // Return size
};

#endif

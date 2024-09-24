#ifndef CUSTOM_TREE_H
#define CUSTOM_TREE_H

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/variant/utility_functions.hpp>
#include "Tree.hpp"

using namespace godot;

class CustomTree : public Node {
    GDCLASS(CustomTree, Node); // Creates a new Godot Class that inherits Node

private:
    Arbol datos; // Intial list with int as its data type

protected:
    static void _bind_methods(); // Method bindings for Godot

public:
    CustomTree(); // Constructor
    ~CustomTree(); // Destructor

    void inicializar(); // Initializes the tree
    int combinar(int value,int value2) ; // Combines two dinosaurs
};

#endif

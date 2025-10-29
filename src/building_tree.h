#ifndef BUILDING_TREE_H
#define BUILDING_TREE_H

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/variant/utility_functions.hpp>
#include "Arbol.hpp"

using namespace godot;

class BuildingTree : public Node {
    GDCLASS(BuildingTree, Node); // Creates a new Godot Class that inherits Node

private:
    ArbolEdificios arbol; // Intial list with int as its data type

protected:
    static void _bind_methods(); // Method bindings for Godot

public:
    BuildingTree(); // Constructor
    ~BuildingTree(); // Destructor

    void insertarValor(int value); // 
};

#endif

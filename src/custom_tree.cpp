#include "custom_tree.h"


CustomTree::CustomTree() {
}

CustomTree::~CustomTree() {
}

void CustomTree::inicializar() {
    datos.inicializar_arbol();
}

int CustomTree::combinar(int value, int value2) {
    return datos.combinar_dinosaurios(value, value2);
}

void CustomTree::_bind_methods() {
    ClassDB::bind_method(D_METHOD("inicializar"), &CustomTree::inicializar);
    ClassDB::bind_method(D_METHOD("combinar", "value", "value2"), &CustomTree::combinar);
    
}

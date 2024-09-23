#ifndef TREE_HPP
#define TREE_HPP

#include <iostream>
#include <string>

using namespace std;

class Nodo {
public:
    string dinosaurio;
    Nodo* padre;
    Nodo* hijo_izquierdo;
    Nodo* hijo_derecho;

    Nodo(string dino) {
        dinosaurio = dino;
        padre = nullptr;
        hijo_izquierdo = nullptr;
        hijo_derecho = nullptr;
    }
};

class Arbol {
public:
    Nodo* raiz;

    Arbol() {
        raiz = nullptr;
    }

    // Inicializar el árbol con cuatro dinosaurios
    void inicializar_arbol() {
        raiz = new Nodo("A");  // Nodo raíz del árbol

        // Hijos del nodo raíz
        raiz->hijo_izquierdo = new Nodo("B");
        raiz->hijo_derecho = new Nodo("C");

        // Hijos de B
        raiz->hijo_izquierdo->hijo_izquierdo = new Nodo("D");
        raiz->hijo_izquierdo->hijo_derecho = new Nodo("E");

        // Hijos de C
        raiz->hijo_derecho->hijo_izquierdo = new Nodo("F");
        raiz->hijo_derecho->hijo_derecho = new Nodo("G");
    }

    // Encontrar el ancestro común más cercano entre dos dinosaurios
    Nodo* encontrar_ancestro_comun(Nodo* nodo, string dino1, string dino2) {
        if (nodo == nullptr)
            return nullptr;

        // Si el nodo actual es alguno de los dinosaurios, devolvemos ese nodo
        if (nodo->dinosaurio == dino1 || nodo->dinosaurio == dino2)
            return nodo;

        // Buscar el ancestro en los subárboles izquierdo y derecho
        Nodo* ancestro_izquierdo = encontrar_ancestro_comun(nodo->hijo_izquierdo, dino1, dino2);
        Nodo* ancestro_derecho = encontrar_ancestro_comun(nodo->hijo_derecho, dino1, dino2);

        // Si ambos subárboles tienen resultado, el nodo actual es el ancestro común
        if (ancestro_izquierdo && ancestro_derecho)
            return nodo;

        // Si solo uno de los subárboles tiene resultado, devolvemos ese subárbol
        return ancestro_izquierdo ? ancestro_izquierdo : ancestro_derecho;
    }

    // Función para combinar dos dinosaurios
    string combinar_dinosaurios(string dino1, string dino2) {
        if (dino1 == dino2)
            return dino1;  // Si son el mismo dinosaurio, no se combinan

        // Encontrar el ancestro común más cercano
        Nodo* ancestro = encontrar_ancestro_comun(raiz, dino1, dino2);
        return ancestro ? ancestro->dinosaurio : "";
    }
};

#endif
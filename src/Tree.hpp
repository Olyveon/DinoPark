#ifndef TREE_HPP
#define TREE_HPP

#include <iostream>

using namespace std;

class Dato {
public:
    int dinosaurio;
    Dato* padre;
    Dato* hijo_izquierdo;
    Dato* hijo_derecho;

    Dato(int dino) {
        dinosaurio = dino;
        padre = nullptr;
        hijo_izquierdo = nullptr;
        hijo_derecho = nullptr;
    }
};

class Arbol {
public:
    Dato* raiz;

    Arbol() {
        raiz = nullptr;
    }

    // Inicializar el árbol con cuatro dinosaurios (ahora usando enteros)
    void inicializar_arbol() {
        raiz = new Dato(1);  // Dato raíz del árbol

        // Hijos del Dato raíz
        raiz->hijo_izquierdo = new Dato(2);
        raiz->hijo_derecho = new Dato(3);

        // Hijos de 2
        raiz->hijo_izquierdo->hijo_izquierdo = new Dato(4);
        raiz->hijo_izquierdo->hijo_derecho = new Dato(5);

        // Hijos de 3
        raiz->hijo_derecho->hijo_izquierdo = new Dato(6);
        raiz->hijo_derecho->hijo_derecho = new Dato(7);
    }

    // Encontrar el ancestro común más cercano entre dos dinosaurios (ahora usando enteros)
    Dato* encontrar_ancestro_comun(Dato* dato, int dino1, int dino2) {
        if (dato == nullptr)
            return nullptr;

        // Si el Dato actual es alguno de los dinosaurios, devolvemos ese Dato
        if (dato->dinosaurio == dino1 || dato->dinosaurio == dino2)
            return dato;

        // Buscar el ancestro en los subárboles izquierdo y derecho
        Dato* ancestro_izquierdo = encontrar_ancestro_comun(dato->hijo_izquierdo, dino1, dino2);
        Dato* ancestro_derecho = encontrar_ancestro_comun(dato->hijo_derecho, dino1, dino2);

        // Si ambos subárboles tienen resultado, el Dato actual es el ancestro común
        if (ancestro_izquierdo && ancestro_derecho)
            return dato;

        // Si solo uno de los subárboles tiene resultado, devolvemos ese subárbol
        return ancestro_izquierdo ? ancestro_izquierdo : ancestro_derecho;
    }

    // Función para combinar dos dinosaurios (ahora usando enteros)
    int combinar_dinosaurios(int dino1, int dino2) {
        if (dino1 == dino2)
            return dino1;  // Si son el mismo dinosaurio, no se combinan

        // Encontrar el ancestro común más cercano
        Dato* ancestro = encontrar_ancestro_comun(raiz, dino1, dino2);
        return ancestro ? ancestro->dinosaurio : -1;  // Devolver -1 si no se encuentra
    }
};
#endif
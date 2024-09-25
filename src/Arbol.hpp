#ifndef ARBOL_HPP
#define ARBOL_HPP


// Clase para definir el Nodo del árbol
class Ndo {
public:
    int edificio;
    Ndo* izquierda;
    Ndo* derecha;

    Ndo(int _edificio) {
        edificio = _edificio;
        izquierda = nullptr;
        derecha = nullptr;
    }
};

// Clase para manejar el árbol binario
class ArbolEdificios {
public:
    Ndo* raiz;

    ArbolEdificios() {
        raiz = nullptr;
    }

    // Insertar un edificio en el árbol
    void insertar(int edificio) {
        if (raiz == nullptr) {
            raiz = new Ndo(edificio);
        } else {
            insertar_recursivo(raiz, edificio);
        }
    }

    // Función recursiva para insertar en el árbol binario
    void insertar_recursivo(Ndo* Ndo_actual, int edificio) {
        if (edificio < Ndo_actual->edificio) {
            if (Ndo_actual->izquierda == nullptr) {
                Ndo_actual->izquierda = new Ndo(edificio);
            } else {
                insertar_recursivo(Ndo_actual->izquierda, edificio);
            }
        } else if (edificio > Ndo_actual->edificio) {
            if (Ndo_actual->derecha == nullptr) {
                Ndo_actual->derecha = new Ndo(edificio);
            } else {
                insertar_recursivo(Ndo_actual->derecha, edificio);
            }
        } 
    }
    
    // Función para buscar el edificio básico para un edificio avanzado en el árbol
    int buscar_edificio_basico(Ndo* Ndo_actual, int edificio_avanzado) {
        if (Ndo_actual == nullptr) {
            return -1;
        }
        if (edificio_avanzado > Ndo_actual->edificio) {
            return Ndo_actual->edificio;
        } else if (edificio_avanzado < Ndo_actual->edificio) {
            return buscar_edificio_basico(Ndo_actual->izquierda, edificio_avanzado);
        } else {
            return -1;
        }
    }
};

#endif
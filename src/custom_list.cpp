#include "custom_list.h"

CustomList::CustomList() {
}

CustomList::~CustomList() {
}

void CustomList::append(const Variant& value) {
    data.appendValue(value);
}

void CustomList::prepend(const Variant& value) {
    data.prependValue(value);
}

bool CustomList::contains(const Variant& value) {
    return data.contains(value);
}

Variant CustomList::get(int index) const {
    if (index >= 0 && index < data.getSize()) {
        return data.getValue(index);
    }
    else {
        UtilityFunctions::push_error("Index out of bounds");
        return Variant(); // Return null variant
    }
}

void CustomList::remove(const Variant& value) {
    data.removeValue(value);
}

int CustomList::size() const {
    return data.getSize();
}

void CustomList::_bind_methods() {
    ClassDB::bind_method(D_METHOD("append", "value"), &CustomList::append);
    ClassDB::bind_method(D_METHOD("prepend", "value"), &CustomList::prepend);
    ClassDB::bind_method(D_METHOD("contains", "value"), &CustomList::contains);
    ClassDB::bind_method(D_METHOD("get", "index"), &CustomList::get);
    ClassDB::bind_method(D_METHOD("remove", "value"), &CustomList::remove);
    ClassDB::bind_method(D_METHOD("size"), &CustomList::size);
}

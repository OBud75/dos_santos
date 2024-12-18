#include "password.hpp"
#include "user.hpp"
#include <iostream>
#include <cassert>

int main() {
    Password password("toto");
    User user(1, password);
    assert(password == "toto");
    
    std::cout << "Test du chiffrement OK" << std::endl;

    user.save();

    std::shared_ptr<User> retrieved_user = User::get(1);
    if (retrieved_user->login("toto")) {
        std::cout << "Login réussi" << std::endl;
    } else {
        std::cout << "Login raté" << std::endl;
    }

    return 0;
}

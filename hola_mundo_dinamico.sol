// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract hola_mundo_dinamico{
    string Saludo_d = "Hola mundo Dinamico";
    string public Saludo_e = "Saludo inicial en el despligue";

    //funcion publica para ser leida tipo view(consulta que no genera cambios en blockchain/sin costo)
    //argumento memory necesario para variables tipo dinamico
    //memory: Hace referencia a los datos NO persistentes
    function leerSaludo() public view returns (string memory) {
        return Saludo_d;
    }
    //funcion publica que genera un cambio/cobro por esta funcion(gas)
    //se sobreescribirá una variable por la variable _nuevoSaludo _

    function guardarSaludo(string memory _nuevoSaludo) public {
        Saludo_d = _nuevoSaludo;
    }
    //se puede verificar el contrato en arbiscan
}
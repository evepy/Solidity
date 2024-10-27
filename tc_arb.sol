// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract tc_arb {
    // direccion de la billetera del creador
    address payable public owner;
    //modelo de Data
    struct Data {
        string date; // fecha de envio
        string delivery_date; // fecha estimada de llegada
        string product; // nombre producto
        string price; // precio del producto
        string code; // identificador del proveedor
        string cel_number; // contacto de la persona que compro el producto
        int8 status; // 1- en camino, 2- llego al pais, 3- esta en la aduana y 4- entregado
        address wallet;
    } 
    Data public data; // instancia de Data
    //modificando la instancia del modelo
    event newData(
        string date,
        string delivery_date,
        string product,
        string price,
        string code,
        string cel_number,
        int8 status,
        address wallet
    );

    //onlyOwner hara que el unico que modifique el contrato sea su propietario
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Solo el propietario puede retirar los fondos"
        );
        _;
    }

    //Verificando el valor de fee y gas, si no hay no se ejecuta
    modifier cost(uint256 amount) {
        require(msg.value >= amount, "No tiene saldo en ARB para ejcutar");
        _;
    }

    // se define quien es el propietario del contrato
    constructor() {
        owner = payable(msg.sender);
    }

    // funcion para cambiar los datos del enum
    function pushData(
        string memory _date,
        string memory _delivery_date,
        string memory _product,
        string memory _price,
        string memory _code,
        string memory _cel_number,
        int8 _status
    ) public payable cost(1000000000000000) {
        data = Data(
            _date,
            _delivery_date,
            _product,
            _price,
            _code,
            _cel_number,
            _status,
            msg.sender
        );

        // es como una especie de log
        emit newData(
            _date,
            _delivery_date,
            _product,
            _price,
            _code,
            _cel_number,
            _status,
            msg.sender
        );
    }

    // funcion para retirar los fondos del contrato
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No se tienen fondos en el contrato todavia");
        owner.transfer(balance);
    }

    // funcion para consultar el valor que se encuentra en el contrato
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

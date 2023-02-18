// SPDX-License-Identifier:MIT
pragma solidity >=0.7.0<0.9.0;
contract Salary_pay{
    address owner;
    mapping(address=>bool) public isEmployee;
    mapping(address=>Employee) employees;
    //we store all employees within an array
    address[] public allEmployees;  
    address[] interns;
    address[] juniors;
    address[] seniors;

    enum Position{Intern, Junior, Senior}
    struct Employee{
        address empAddress;
        Position empPosition;
        uint salary;
    }

    constructor(){
        owner=msg.sender;
    }

    function addEmployee (address payable empAddress, Position _position) public{
        isEmployee[empAddress]=true;
        uint pay;
        if(_position==Position.Intern){
            interns.push(empAddress);
            pay=0.001 ether;    //pre-defined cost of payment
        }
        else if(_position==Position.Junior){
            juniors.push(empAddress);
            pay=0.002 ether;    //pre-defined cost of payment
   
        }
        else if(_position==Position.Senior){
            seniors.push(empAddress);
            pay=0.004 ether;
        }

        Employee memory newEmployee=Employee(empAddress,_position,pay);
        employees[empAddress]=newEmployee;
        allEmployees.push(empAddress);
    }

    //function to get all the employees
    //why we define this function as payable is because,
    //but this expression (potentially) modifies the state and thus requires non-payable (the default) or payable.
    function getAllEmployees() public payable(address[]memory, address[] memory,address[] memory){
        for(uint i=0;i<allEmployees.length;i++){
            payable(allEmployees[i]).transfer(employees[allEmployees[i]].salary);
        }
    }

    //function for balance
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
    
}
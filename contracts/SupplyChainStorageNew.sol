pragma solidity ^ 0.4 .23;

import "./SupplyChainStorageOwnable.sol";

contract SupplyChainStorage is SupplyChainStorageOwnable {

    address public lastAccess;

    constructor() public {
        authorizedCaller[msg.sender] = 1;
        emit AuthorizedCaller(msg.sender);
    }


    event AuthorizedCaller(address caller);
    event DeAuthorizedCaller(address caller);



    modifier onlyAuthCaller() {
        lastAccess = msg.sender;
        require(authorizedCaller[msg.sender] == 1);
        _;
    }


    struct user {
        string name;
        string contactNo;
        bool isActive;
        string profileHash;
    }

    mapping(address => user) userDetails;
    mapping(address => string) userRole;


    mapping(address => uint8) authorizedCaller;


    function authorizeCaller(address _caller) public onlyOwner returns(bool) {
        authorizedCaller[_caller] = 1;
        emit AuthorizedCaller(_caller);
        return true;
    }


    function deAuthorizeCaller(address _caller) public onlyOwner returns(bool) {
        authorizedCaller[_caller] = 0;
        emit DeAuthorizedCaller(_caller);
        return true;
    }



    struct basicDetails {
        string registrationNo;
        string companyName;
        string companyAddress;
    }



    // struct miningCompany {
    //     string oreName;
    //     uint256 oreOutput;
    //     uint256 carbonEmission;
    // }
    struct rawMaterialExtractor {
        string rawMaterialName;
        uint256 rawMaterialWeight;
        uint256 carbonEmission;
        uint256 avgWorkerAge;
        bool isChildLabourUsed;
    }


    // struct refiningCompany {
    //     string refinedComponent;
    //     uint256 refinedOutput;
    //     uint256 carbonEmission;
    // }
    struct chemicalProcessor {
        string refinedComponent;
        uint256 refinedOutput;
        uint256 carbonEmission;
        uint256 amountDisposed;
    }

    // struct cellComponentProducer {
    //     string companyName;
    //     string companyAddress;
    //     string componentName;

    //     uint256 componentOutput;
    //     uint256 recycledMaterialsUsed;


    //     uint256 carbonEmission;
    // }
    struct polymerizationCompany {
        string companyName;
        string companyAddress;
        string componentName;

        uint256 componentOutput;
        uint256 recycledMaterialsUsed;

        uint256 amountDisposed;

        uint256 carbonEmission;
    }


    // struct cellPackProducer {
    //     string companyAddress;
    //     string componentName;
    //     uint256 cellPackOutput;
    //     uint256 recycledMaterialsUsed;
    //     uint256 carbonEmission;
    // }
    struct filamentProducer {
        string companyAddress;
        string componentName;
        string filamentType;
        uint256 filamentOutput;
        uint256 recycledMaterialsUsed;
        uint256 carbonEmission;
        uint256 amountDisposed;

    }

    // struct transporter {
    //     uint256 tonnage;
    //     uint256 distanceTransported;
    //     uint256 carbonEmission;
    //     uint256 renewableFuelUsed;
    //     string source;
    //     string destination;
    // }
    struct ThreeDPrintingCompany {
        // printed file
        uint256 printime;
        uint256 energyUsed;
        uint256 carbonEmission;
        uint256 partWeight;
        uint256 scrapWeight;
        uint256 amountDisposed;

    }

    // struct customer {
    //     uint256 ratioEnergy;
    //     uint256 ratioPowerDensity;
    //     uint256 ratioPower;
    //     uint256 cycleLife;
    //     string purchaseDate;
    //     string customerName;
    // }
    struct recyclingCompany {

        uint256 amountDisposed;

    }

    // struct recycler {
    //     uint256 wholeCells;
    //     uint256 cellComponents;
    //     uint256 packageDateTime;
    //     uint256 carbonEmission;
    //     uint256 renewableFuelUsed;
    //     string source;
    //     string destination;
    //     string companyName;
    //     string companyAddress;
    // }


    // mapping(address => basicDetails) batchBasicDetails;
    // mapping(address => miningCompany) batchMiningCompany;
    // mapping(address => refiningCompany) batchRefiningCompany;
    // mapping(address => cellComponentProducer) batchCellComponentProducer;
    // mapping(address => cellPackProducer) batchCellPackProducer;
    // mapping(address => transporter) batchTransporter;
    // mapping(address => customer) batchCustomer;
    // mapping(address => recycler) batchRecycler;
    // mapping(address => string) nextAction;
    mapping(address => basicDetails) batchBasicDetails;
    mapping(address => rawMaterialExtractor) batchRawMaterialExtractor;
    mapping(address => chemicalProcessor) batchChemicalProcessor;
    mapping(address => polymerizationCompany) batchPolymerizationCompany;
    mapping(address => filamentProducer) batchFilamentProducer;
    mapping(address => ThreeDPrintingCompany) batch3DPrintingCompany;
    mapping(address => recyclingCompany) batchRecyclingCompany;
    // mapping(address => recycler) batchRecycler;
    mapping(address => string) nextAction;


    // user userDetail;
    // basicDetails basicDetailsData;
    // miningCompany miningCompanyData;
    // refiningCompany refiningCompanyData;
    // cellComponentProducer cellComponentProducerData;
    // cellPackProducer cellPackProducerData;
    // transporter transporterData;
    // customer customerData;
    // recycler recyclerData;
    user userDetail;
    basicDetails basicDetailsData;
    rawMaterialExtractor rawMaterialExtractorData;
    chemicalProcessor chemicalProcessorData;
    polymerizationCompany polymerizationCompanyData;
    cellPackProducer cellPackProducerDataData;
    filamentProducer filamentProducerData;
    3DPrintingCompany 3DPrintingCompanyData;
    recyclingCompany recyclingCompanyData;


    function getUserRole(address _userAddress) public onlyAuthCaller view returns(string) {
        return userRole[_userAddress];
    }


    function getNextAction(address _batchNo) public onlyAuthCaller view returns(string) {
        return nextAction[_batchNo];
    }


    function setUser(address _userAddress,
        string _name,
        string _contactNo,
        string _role,
        bool _isActive,
        string _profileHash) public onlyAuthCaller returns(bool) {


        userDetail.name = _name;
        userDetail.contactNo = _contactNo;
        userDetail.isActive = _isActive;
        userDetail.profileHash = _profileHash;


        userDetails[_userAddress] = userDetail;
        userRole[_userAddress] = _role;

        return true;
    }


    function getUser(address _userAddress) public onlyAuthCaller view returns(string name,
        string contactNo,
        string role,
        bool isActive,
        string profileHash
    ) {


        user memory tmpData = userDetails[_userAddress];

        return (tmpData.name, tmpData.contactNo, userRole[_userAddress], tmpData.isActive, tmpData.profileHash);
    }


    function getBasicDetails(address _batchNo) public onlyAuthCaller view returns(string registrationNo,
        string companyName,
        string companyAddress) {

        basicDetails memory tmpData = batchBasicDetails[_batchNo];

        return (tmpData.registrationNo, tmpData.companyName, tmpData.companyAddress);
    }


    function setBasicDetails(string _registrationNo,
        string _companyName,
        string _companyAddress
    ) public onlyAuthCaller returns(address) {

        uint tmpData = uint(keccak256(msg.sender, now));
        address batchNo = address(tmpData);

        basicDetailsData.registrationNo = _registrationNo;
        basicDetailsData.companyName = _companyName;
        basicDetailsData.companyAddress = _companyAddress;

        batchBasicDetails[batchNo] = basicDetailsData;

        nextAction[batchNo] = 'RAWMATERIALEXTRACTION';

        return batchNo;
    }



    // function setMiningCompanyData(address batchNo,
    //     string _oreName,
    //     uint256 _oreOutput,
    //     uint256 _carbonEmission) public onlyAuthCaller returns(bool) {

    //     miningCompanyData.oreName = _oreName;
    //     miningCompanyData.oreOutput = _oreOutput;
    //     miningCompanyData.carbonEmission = _carbonEmission;

    //     batchMiningCompany[batchNo] = miningCompanyData;

    //     nextAction[batchNo] = 'REFINING';

    //     return true;
    // }
    function setRawMaterialExtractorData(address batchNo,
        string _rawMaterialName,
        uint256 _oreOutput,
        uint256 _carbonEmission) public onlyAuthCaller returns(bool) {

        rawMaterialExtractorData.rawMaterialName = _rawMaterialName;
        rawMaterialExtractorData.rawMaterialWeight = _rawMaterialWeight;
        rawMaterialExtractorData.carbonEmission = _carbonEmission;

        batchRawMaterialExtractor[batchNo] = rawMaterialExtractorData;

        nextAction[batchNo] = 'CHEMICALPROCESSING';

        return true;
    }


    // function getMiningCompanyData(address batchNo) public onlyAuthCaller view returns(string oreName, uint256 oreOutput, uint256 carbonEmission) {

    //     miningCompany memory tmpData = batchMiningCompany[batchNo];
    //     return (tmpData.oreName, tmpData.oreOutput, tmpData.carbonEmission);
    // }
    function getRawMaterialExtractorData(address batchNo) public onlyAuthCaller view returns(string rawMaterialName,
        uint256 rawMaterialWeight,
        uint256 carbonEmission) {

        rawMaterialExtractor memory tmpData = batchRawMaterialExtractor[batchNo];
        return (tmpData.rawMaterialName, tmpData.rawMaterialWeight, tmpData.carbonEmission);
    }

    // function setRefiningCompanyData(address batchNo,
    //     string _refinedComponent,
    //     uint256 _refinedOutput,
    //     uint256 _carbonEmission) public onlyAuthCaller returns(bool) {

    //     refiningCompanyData.refinedComponent = _refinedComponent;
    //     refiningCompanyData.refinedOutput = _refinedOutput;
    //     refiningCompanyData.carbonEmission = _carbonEmission;

    //     batchRefiningCompany[batchNo] = refiningCompanyData;

    //     nextAction[batchNo] = 'CELLCOMP';

    //     return true;
    // }
    function setChemicalProcessorData(address batchNo,
        string _refinedComponent,
        uint256 _refinedOutput,
        uint256 _carbonEmission) public onlyAuthCaller returns(bool) {

        refiningCompanyData.refinedComponent = _refinedComponent;
        refiningCompanyData.refinedOutput = _refinedOutput;
        refiningCompanyData.carbonEmission = _carbonEmission;

        batchRefiningCompany[batchNo] = refiningCompanyData;

        nextAction[batchNo] = 'CELLCOMP';

        return true;
    }

    // function getRefiningCompanyData(address batchNo) public onlyAuthCaller view returns(string refinedComponent,
    //     uint256 refinedOutput,
    //     uint256 carbonEmission) {

    //     refiningCompany memory tmpData = batchRefiningCompany[batchNo];
    //     return (tmpData.refinedComponent, tmpData.refinedOutput, tmpData.carbonEmission);
    // }
    function getRefiningCompanyData(address batchNo) public onlyAuthCaller view returns(string refinedComponent,
        uint256 refinedOutput,
        uint256 carbonEmission) {

        refiningCompany memory tmpData = batchRefiningCompany[batchNo];
        return (tmpData.refinedComponent, tmpData.refinedOutput, tmpData.carbonEmission);
    }

    // function setCellComponentProducerData(address batchNo, string _companyName, string _companyAddress,
    //     string _componentName, uint256 _componentOutput, uint256 _recycledMaterialsUsed,
    //     uint256 _carbonEmission) public onlyAuthCaller returns(bool) {

    //     cellComponentProducerData.companyName = _companyName;
    //     cellComponentProducerData.companyAddress = _companyAddress;
    //     cellComponentProducerData.componentName = _componentName;
    //     cellComponentProducerData.componentOutput = _componentOutput;
    //     cellComponentProducerData.recycledMaterialsUsed = _recycledMaterialsUsed;
    //     cellComponentProducerData.carbonEmission = _carbonEmission;

    //     batchCellComponentProducer[batchNo] = cellComponentProducerData;

    //     nextAction[batchNo] = 'CELLPACK';

    //     return true;
    // }
    function setCellComponentProducerData(address batchNo, string _companyName, string _companyAddress,
        string _componentName, uint256 _componentOutput, uint256 _recycledMaterialsUsed,
        uint256 _carbonEmission) public onlyAuthCaller returns(bool) {

        cellComponentProducerData.companyName = _companyName;
        cellComponentProducerData.companyAddress = _companyAddress;
        cellComponentProducerData.componentName = _componentName;
        cellComponentProducerData.componentOutput = _componentOutput;
        cellComponentProducerData.recycledMaterialsUsed = _recycledMaterialsUsed;
        cellComponentProducerData.carbonEmission = _carbonEmission;

        batchCellComponentProducer[batchNo] = cellComponentProducerData;

        nextAction[batchNo] = 'CELLPACK';

        return true;
    }


    // function getCellComponentProducerData(address batchNo) public onlyAuthCaller view returns(string companyName, string companyAddress, string componentName,
    //     uint256 componentOutput, uint256 recycledMaterialsUsed, uint256 carbonEmission) {


    //     cellComponentProducer memory tmpData = batchCellComponentProducer[batchNo];


    //     return (tmpData.companyName,
    //         tmpData.companyAddress,
    //         tmpData.componentName,
    //         tmpData.componentOutput,
    //         tmpData.recycledMaterialsUsed,
    //         tmpData.carbonEmission);

    // }
    function getCellComponentProducerData(address batchNo) public onlyAuthCaller view returns(string companyName, string companyAddress, string componentName,
        uint256 componentOutput, uint256 recycledMaterialsUsed, uint256 carbonEmission) {


        cellComponentProducer memory tmpData = batchCellComponentProducer[batchNo];


        return (tmpData.companyName,
            tmpData.companyAddress,
            tmpData.componentName,
            tmpData.componentOutput,
            tmpData.recycledMaterialsUsed,
            tmpData.carbonEmission);

    }


    // function setCellPackProducerData(address batchNo,
    //     string _companyAddress,
    //     string _componentName,
    //     uint256 _cellPackOutput,
    //     uint256 _recycledMaterialsUsed,
    //     uint256 _carbonEmission) public onlyAuthCaller returns(bool) {

    //     cellPackProducerData.companyAddress = _companyAddress;
    //     cellPackProducerData.componentName = _componentName;
    //     cellPackProducerData.cellPackOutput = _cellPackOutput;
    //     cellPackProducerData.recycledMaterialsUsed = _recycledMaterialsUsed;
    //     cellPackProducerData.carbonEmission = _carbonEmission;

    //     batchCellPackProducer[batchNo] = cellPackProducerData;

    //     nextAction[batchNo] = 'TRANSPORT';

    //     return true;
    // }
    function setCellPackProducerData(address batchNo,
        string _companyAddress,
        string _componentName,
        uint256 _cellPackOutput,
        uint256 _recycledMaterialsUsed,
        uint256 _carbonEmission) public onlyAuthCaller returns(bool) {

        cellPackProducerData.companyAddress = _companyAddress;
        cellPackProducerData.componentName = _componentName;
        cellPackProducerData.cellPackOutput = _cellPackOutput;
        cellPackProducerData.recycledMaterialsUsed = _recycledMaterialsUsed;
        cellPackProducerData.carbonEmission = _carbonEmission;

        batchCellPackProducer[batchNo] = cellPackProducerData;

        nextAction[batchNo] = 'TRANSPORT';

        return true;
    }


    // function getCellPackProducerData(address batchNo) public onlyAuthCaller view returns(string companyAddress,
    //     string componentName,
    //     uint256 cellPackOutput,
    //     uint256 recycledMaterialsUsed,
    //     uint256 carbonEmission) {

    //     cellPackProducer memory tmpData = batchCellPackProducer[batchNo];


    //     return (tmpData.companyAddress,
    //         tmpData.componentName,
    //         tmpData.cellPackOutput,
    //         tmpData.recycledMaterialsUsed,
    //         tmpData.carbonEmission);


    // }
    function getCellPackProducerData(address batchNo) public onlyAuthCaller view returns(string companyAddress,
        string componentName,
        uint256 cellPackOutput,
        uint256 recycledMaterialsUsed,
        uint256 carbonEmission) {

        cellPackProducer memory tmpData = batchCellPackProducer[batchNo];


        return (tmpData.companyAddress,
            tmpData.componentName,
            tmpData.cellPackOutput,
            tmpData.recycledMaterialsUsed,
            tmpData.carbonEmission);


    }


    // function setTransporterData(address batchNo,
    //     uint256 _tonnage,
    //     uint256 _distanceTransported,
    //     uint256 _carbonEmission,
    //     uint256 _renewableFuelUsed,
    //     string _source,
    //     string _destination) public onlyAuthCaller returns(bool) {
    //     transporterData.tonnage = _tonnage;
    //     transporterData.distanceTransported = _distanceTransported;
    //     transporterData.carbonEmission = _carbonEmission;
    //     transporterData.renewableFuelUsed = _renewableFuelUsed;
    //     transporterData.source = _source;
    //     transporterData.destination = _destination;
    //     batchTransporter[batchNo] = transporterData;
    //     nextAction[batchNo] = 'USER';
    //     return true;
    // }
    function setTransporterData(address batchNo,
        uint256 _tonnage,
        uint256 _distanceTransported,
        uint256 _carbonEmission,
        uint256 _renewableFuelUsed,
        string _source,
        string _destination) public onlyAuthCaller returns(bool) {
        transporterData.tonnage = _tonnage;
        transporterData.distanceTransported = _distanceTransported;
        transporterData.carbonEmission = _carbonEmission;
        transporterData.renewableFuelUsed = _renewableFuelUsed;
        transporterData.source = _source;
        transporterData.destination = _destination;
        batchTransporter[batchNo] = transporterData;
        nextAction[batchNo] = 'USER';
        return true;
    }

    // function getTransporterData(address batchNo) public onlyAuthCaller view returns(
    //     uint256 tonnage,
    //     uint256 distanceTransported,
    //     uint256 carbonEmission,
    //     uint256 renewableFuelUsed,
    //     string source,
    //     string destination) {

    //     transporter memory tmpData = batchTransporter[batchNo];


    //     return (
    //         tmpData.tonnage,
    //         tmpData.distanceTransported,
    //         tmpData.carbonEmission,
    //         tmpData.renewableFuelUsed,
    //         tmpData.source,
    //         tmpData.destination);

    // }
    function getTransporterData(address batchNo) public onlyAuthCaller view returns(
        uint256 tonnage,
        uint256 distanceTransported,
        uint256 carbonEmission,
        uint256 renewableFuelUsed,
        string source,
        string destination) {

        transporter memory tmpData = batchTransporter[batchNo];


        return (
            tmpData.tonnage,
            tmpData.distanceTransported,
            tmpData.carbonEmission,
            tmpData.renewableFuelUsed,
            tmpData.source,
            tmpData.destination);

    }


    // function setCustomerData(address batchNo,
    //     uint256 _ratioEnergy,
    //     uint256 _ratioPowerDensity,
    //     uint256 _ratioPower,
    //     uint256 _cycleLife,
    //     string _purchaseDate,
    //     string _customerName) public onlyAuthCaller returns(bool) {


    //     customerData.ratioEnergy = _ratioEnergy;
    //     customerData.ratioPowerDensity = _ratioPowerDensity;
    //     customerData.ratioPower = _ratioPower;
    //     customerData.cycleLife = _cycleLife;
    //     customerData.purchaseDate = _purchaseDate;
    //     customerData.customerName = _customerName;

    //     batchCustomer[batchNo] = customerData;
    //     nextAction[batchNo] = 'RECYCLER';
    //     return true;
    // }
    function setCustomerData(address batchNo,
        uint256 _ratioEnergy,
        uint256 _ratioPowerDensity,
        uint256 _ratioPower,
        uint256 _cycleLife,
        string _purchaseDate,
        string _customerName) public onlyAuthCaller returns(bool) {


        customerData.ratioEnergy = _ratioEnergy;
        customerData.ratioPowerDensity = _ratioPowerDensity;
        customerData.ratioPower = _ratioPower;
        customerData.cycleLife = _cycleLife;
        customerData.purchaseDate = _purchaseDate;
        customerData.customerName = _customerName;

        batchCustomer[batchNo] = customerData;
        nextAction[batchNo] = 'RECYCLER';
        return true;
    }

    // function getCustomerData(address batchNo) public onlyAuthCaller view returns(
    //     uint256 ratioEnergy,
    //     uint256 ratioPowerDensity,
    //     uint256 ratioPower,
    //     uint256 cycleLife,
    //     string purchaseDate,
    //     string customerName) {

    //     customer memory tmpData = batchCustomer[batchNo];


    //     return (
    //         tmpData.ratioEnergy,
    //         tmpData.ratioPowerDensity,
    //         tmpData.ratioPower,
    //         tmpData.cycleLife,
    //         tmpData.purchaseDate,
    //         tmpData.customerName);
    // }
    function getCustomerData(address batchNo) public onlyAuthCaller view returns(
        uint256 ratioEnergy,
        uint256 ratioPowerDensity,
        uint256 ratioPower,
        uint256 cycleLife,
        string purchaseDate,
        string customerName) {

        customer memory tmpData = batchCustomer[batchNo];


        return (
            tmpData.ratioEnergy,
            tmpData.ratioPowerDensity,
            tmpData.ratioPower,
            tmpData.cycleLife,
            tmpData.purchaseDate,
            tmpData.customerName);
    }



    // function setRecyclerData(address batchNo,
    //     uint256 _wholeCells,
    //     uint256 _cellComponents,
    //     uint256 _carbonEmission,
    //     uint256 _renewableFuelUsed,
    //     string _source,
    //     string _destination) public onlyAuthCaller returns(bool) {


    //     recyclerData.wholeCells = _wholeCells;
    //     recyclerData.cellComponents = _cellComponents;
    //     recyclerData.carbonEmission = _carbonEmission;
    //     recyclerData.renewableFuelUsed = _renewableFuelUsed;
    //     recyclerData.source = _source;
    //     recyclerData.destination = _destination;


    //     batchRecycler[batchNo] = recyclerData;

    //     nextAction[batchNo] = 'DONE';

    //     return true;

    // }
    function setRecyclerData(address batchNo,
        uint256 _wholeCells,
        uint256 _cellComponents,
        uint256 _carbonEmission,
        uint256 _renewableFuelUsed,
        string _source,
        string _destination) public onlyAuthCaller returns(bool) {


        recyclerData.wholeCells = _wholeCells;
        recyclerData.cellComponents = _cellComponents;
        recyclerData.carbonEmission = _carbonEmission;
        recyclerData.renewableFuelUsed = _renewableFuelUsed;
        recyclerData.source = _source;
        recyclerData.destination = _destination;


        batchRecycler[batchNo] = recyclerData;

        nextAction[batchNo] = 'DONE';

        return true;

    }

    // function getRecyclerData(address batchNo) public onlyAuthCaller view returns(
    //     uint256 wholeCells,
    //     uint256 cellComponents,
    //     uint256 carbonEmission,
    //     uint256 renewableFuelUsed,
    //     string source,
    //     string destination) {

    //     recycler memory tmpData = batchRecycler[batchNo];


    //     return (
    //         tmpData.wholeCells,
    //         tmpData.cellComponents,
    //         tmpData.carbonEmission,
    //         tmpData.renewableFuelUsed,
    //         tmpData.source,
    //         tmpData.destination);

    // }
    function getRecyclerData(address batchNo) public onlyAuthCaller view returns(
        uint256 wholeCells,
        uint256 cellComponents,
        uint256 carbonEmission,
        uint256 renewableFuelUsed,
        string source,
        string destination) {

        recycler memory tmpData = batchRecycler[batchNo];


        return (
            tmpData.wholeCells,
            tmpData.cellComponents,
            tmpData.carbonEmission,
            tmpData.renewableFuelUsed,
            tmpData.source,
            tmpData.destination);

    }


}
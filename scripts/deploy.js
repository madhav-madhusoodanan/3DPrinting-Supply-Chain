async function main() {
    // We get the contract to deploy
    const SCS = await ethers.getContractFactory("SupplyChainStorage")
    const scs = await SCS.deploy()
    await scs.deployed()

    await scs.deployed()

    console.log("SupplyChainStorage deployed to:", scs.address)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })

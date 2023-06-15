import Foundation

// Represents a recycling bin
class RecyclingBin {
    // Represents a recycling bin with counters for different materials and an array to store invalid inputs
    private var totalPaper: Int
    private var totalPlastic: Int
    private var totalGlass: Int
    private var totalMetal: Int
    private var invalidInputs: [String]

    // Initialize the recycling bin with default values
    init() {
        totalPaper = 0
        totalPlastic = 0
        totalGlass = 0
        totalMetal = 0
        invalidInputs = []
    }


    // Add the specified quantity of paper to the bin
    func addPaper(_ quantity: Int) {
        totalPaper += quantity
    }

    // Add the specified quantity of plastic to the bin
    func addPlastic(_ quantity: Int) {
        totalPlastic += quantity
    }

    // Add the specified quantity of glass to the bin
    func addGlass(_ quantity: Int) {
        totalGlass += quantity
    }

    // Add the specified quantity of metal to the bin
    func addMetal(_ quantity: Int) {
        totalMetal += quantity
    }

    // Add an invalid input to the bin
    func addInvalidInput(_ input: String) {
        invalidInputs.append(input)
    }

    // Calculate the total quantity of recycled items in the bin
    func calculateTotalRecycled() -> Int {
        return totalPaper + totalPlastic + totalGlass + totalMetal
    }

    // Calculate the percentage of each material recycled in relation to the total recycled items
    func calculatePercentageRecycled() -> [String: Double] {

        // Calculate the total quantity of recycled materials
        let totalRecycled = calculateTotalRecycled()

        // Create an empty dictionary to store the percentage of each material recycled
        var percentageMap: [String: Double] = [:]


        // Calculate the percentage of each material recycled if the total recycled is greater than 0
        if totalRecycled > 0 {
            percentageMap["paper"] = Double(totalPaper) / Double(totalRecycled) * 100
            percentageMap["plastic"] = Double(totalPlastic) / Double(totalRecycled) * 100
            percentageMap["glass"] = Double(totalGlass) / Double(totalRecycled) * 100
            percentageMap["metal"] = Double(totalMetal) / Double(totalRecycled) * 100
        }

        // Return the dictionary containing the percentage of each material recycled
        return percentageMap
    }

    // Get the list of invalid inputs
    func getInvalidInputs() -> [String] {
        return invalidInputs
    }
}

// Process the input file and generate the output file
func processInputFile(_ inputFileName: String, _ outputFileName: String) {
    // Get the default file manager
    let fileManager = FileManager.default

    // Get the URL for the current working directory
    let currentDirectoryURL = URL(fileURLWithPath: fileManager.currentDirectoryPath)

    // Create the URL for the input file by appending the input file name to the current directory URL
    let inputURL = currentDirectoryURL.appendingPathComponent(inputFileName)

    // Create the URL for the output file by appending the output file name to the current directory URL
    let outputURL = currentDirectoryURL.appendingPathComponent(outputFileName)


    do {
        // Read the contents of the input file
        let inputString = try String(contentsOf: inputURL, encoding: .utf8)
        let inputLines = inputString.components(separatedBy: .newlines)
        let bin = RecyclingBin()

        // Process each line of the input file
        for line in inputLines {
            let parts = line.components(separatedBy: ", ")

            // Check if the number of parts is equal to 2
            if parts.count == 2 {
                // Extract the material from the first part and convert it to lowercase
                let material = parts[0].lowercased()
    
                // Attempt to convert the second part to an integer quantity
                if let quantity = Int(parts[1]) {
                    // The conversion was successful
                    // Check the value of the `material` variable to determine the appropriate action
                    switch material {
                        case "paper":
                            // Add the quantity to the total paper count in the recycling bin
                            bin.addPaper(quantity)
                        case "plastic":
                            // Add the quantity to the total plastic count in the recycling bin
                            bin.addPlastic(quantity)
                        case "glass":
                            // Add the quantity to the total glass count in the recycling bin
                            bin.addGlass(quantity)
                        case "metal":
                            // Add the quantity to the total metal count in the recycling bin
                            bin.addMetal(quantity)
                        default:
                            // The material is not recognized, add the entire line as an invalid input
                            bin.addInvalidInput(line)
                    }
                } else {
                    // Invalid quantity format, add the entire line as an invalid input
                    bin.addInvalidInput(line)
                }
            } else {
                // Invalid line format, add the entire line as an invalid input
                bin.addInvalidInput(line)
            }
        }

        // Calculate total recycled items and percentage of each material recycled
        let totalRecycled = bin.calculateTotalRecycled()
        let percentageMap = bin.calculatePercentageRecycled()

        // Format the output string
        let formattedOutput = """
        Total recycled: \(totalRecycled)
        Paper percentage: \(String(format: "%.2f", percentageMap["paper"] ?? 0))%
        Plastic percentage: \(String(format: "%.2f", percentageMap["plastic"] ?? 0))%
        Glass percentage: \(String(format: "%.2f", percentageMap["glass"] ?? 0))%
        Metal percentage: \(String(format: "%.2f", percentageMap["metal"] ?? 0))%
        """

        // Write the formatted output to the output file
        try formattedOutput.write(to: outputURL, atomically: true, encoding: .utf8)
        print("Output file created successfully.")
    } catch {
        // Display error.
        print("Error reading or writing file: \(error)")
    }
}

// Example usage
let inputFileName = "input.txt"
let outputFileName = "output.txt"
processInputFile(inputFileName, outputFileName)

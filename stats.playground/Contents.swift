import Cocoa

extension Array where Element: FloatingPoint {
    
    func len() -> Element {
        return Element(self.count)
    }
    
    func sum() -> Element {
        return self.reduce(0, +)
    }
    
    func range() -> Element {
        return self.max()! - self.min()!
    }

    func mean() -> Element {
        return self.sum() / Element(self.count)
    }
    
    func median() -> Element {
        if self.count % 2 == 0{
            let median1 = self.sorted()[self.count / 2]
            let median2 = self.sorted()[(self.count / 2) - 1]
            return (median1 + median2) / 2
        } else {
            return self.sorted()[self.count / 2]
        }
    }

    func std() -> Element {
        //Step 1
        let mean = self.mean()

        // Step 2 use reduce to add them together
        let totalAverage = self.reduce(0, { $0 + ($1-mean)*($1-mean) })
        
        // Step 3 square root
        return sqrt(totalAverage / (Element(self.count) - 1))
    }
}


//NEED TO INTEGRATE AS EXTENSION
func correlation(x: [Float], y: [Float]) -> Float {
    //https://www.statisticshowto.com/probability-and-statistics/correlation-coefficient-formula/#hand
    
    //STEP 1 - SUM x and y
    let Σx = x.sum()
    let Σy = y.sum()
    
    //STEP 2 - Multiply each of the elements in x and y togehter and put in a new list
    var xy: [Float] = []
    if x.count == y.count{
        xy = zip(x, y).map(*)
    }

    //STEP 3 - Take the square of the numbers in x column and put the results in the x squared column
    let x2 = x.map{pow($0, 2)}
    
    //STEP 4 - Take the square of the numbers in x column and put the results in the y squared column
    let y2 = y.map{pow($0, 2)}
    
    //STEP 5 - Add up all the numbers in each of the columns
    let Σx2 = x2.sum()
    let Σy2 = y2.sum()
    let Σxy = xy.sum()
    
    //STEP 6 - Use Correlation Formula
    var length:Float  = 0
    if x.count == y.count{
        length = x.len()
    }
    
    let r = ((length * Σxy) - (Σx * Σy)) / (sqrt(((length * Σx2) - pow(Σx, 2)) * ((length * Σy2) - pow(Σy, 2))))

    return r
}



//TEST DATA
let ageX: [Float] = [43, 21, 25, 42, 57, 59]
let glugoseY: [Float] = [99, 65, 79, 75, 87, 81]

let heights: [Float] = [70.0, 74.0, 74.0, 72.0, 71.0, 73.0, 72.0, 74.0, 74.0, 73.0, 76.0, 73.0, 73.0, 76.0, 73.0, 74.0, 75.0]
let weights: [Float] = [180.0, 185.0, 188.0, 190.0, 194.0, 195.0, 195.0, 200.0, 205.0, 205.0, 212.0, 225.0, 230.0, 230.0, 235.0, 240.0, 255.0]

let studentH: [Float] = [74, 66, 68, 69, 73, 70, 60, 63]
let studentW: [Float] = [193, 133, 155, 147, 175, 128, 100, 128]


//RUNNING...
/*
print("Min: \(values.min())")
print("Max: \(values.max())")
print("Range: \(values.range())")
print("Sum: \(values.sum())")
print("Mean: \(values.mean())")
print("Median: \(values.median())")
print("Variance \(values.variance())")
print("Standard Deviation: \(values.std())")
print("Coefficient of Variance: \(values.cv())")
*/

let sd = studentH.std()
print("Standard Deviation: \(sd)")

let corr = correlation(x: ageX, y: glugoseY)
print("Correlation: \(corr)")

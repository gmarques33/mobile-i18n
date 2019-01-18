import Foundation
import XCTest
import Yaml
@testable import i18nGenCore

func makeInput(language: String, string: String) throws -> InputRepresentation {
    return try InputRepresentation(
        language: language,
        yamlString: string,
        path: URL(string: "/")!
    )
}

class InputRepresentationTests: XCTestCase {
    
    func testLanguageMatch() {
        let string = """
        en:
          first: "First"
          second:
            third: "Third {{ param }}"
        """
        
        XCTAssertNoThrow(try makeInput(language: "en", string: string))
        XCTAssertThrowsError(try makeInput(language: "es", string: string))
    }
    
    func testMatch() {
        let first = """
        en:
          first: "First"
          second:
            third: "Third {{ param }}"
        """
        
        let second = """
        pt-br:
          first: "Primeiro"
          second:
            third: "Terceiro {{ param }}"
        """
        
        let firstInput = try! makeInput(language: "en", string: first)
        let secondInput = try! makeInput(language: "pt-br", string: second)
        
        XCTAssertTrue(firstInput.matches(representation: secondInput))
    }
    
    func testMismatch() {
        let first = """
        en:
          first: "First"
          second:
            third: "Third {{ param }}"
        """
        
        let second = """
        pt-br:
          first: "Primeiro"
          second:
            third: "Terceiro"
        """
        
        let firstInput = try! makeInput(language: "en", string: first)
        let secondInput = try! makeInput(language: "pt-br", string: second)
        
        XCTAssertFalse(firstInput.matches(representation: secondInput))
    }
    
    func testAnotherMismatch() {
        let first = """
        en:
          first: "First"
          second:
            third: "Third {{ param }}"
            fourth: "Fourth"
        """
        
        let second = """
        pt-br:
          first: "Primeiro"
          second:
            third: "Terceiro"
        """
        
        let firstInput = try! makeInput(language: "en", string: first)
        let secondInput = try! makeInput(language: "pt-br", string: second)
        
        XCTAssertFalse(firstInput.matches(representation: secondInput))
    }
}

class OutputRepresentationTests: XCTestCase {
    
    // TODO: Write tests
}

class SwiftGenerationTests: XCTestCase {
    
    // TODO: Write tests
}

class KotlinGenerationTests: XCTestCase {
    
    // TODO: Write tests
}
//
//  Qoutes.swift
//  MoveApp
//
//  Created by ashley canty on 8/10/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit


struct Qoute {
    var author: String
    var qoute: String
}

struct Qoutes {
    let qoutes = [
        "― Lisa See":"Read a thousand books, and your words will flow like a river.",
        "― Terry Pratchett":"“The first draft is just you telling yourself the story.”",
        "― Octavia E. Butler":"You don’t start out writing good stuff. You start out writing crap and thinking it’s good stuff, and then gradually you get better at it.",
        "― Jodi Picoult":"You can always edit a bad page. You can’t edit a blank page.",
        "— Louis L’Amour":"Start writing, no matter what. The water does not flow until the faucet is turned on.",
        "— Virginia Woolf":"Every secret of a writer’s soul, every experience of his life, every quality of his mind, is written large in his works.",
        "― Sylvia Plath":"And by the way, everything in life is writable about if you have the outgoing guts to do it, and the imagination to improvise. The worst enemy to creativity is self-doubt.",
        "― Anton Chekhov":"Don’t tell me the moon is shining; show me the glint of light on broken glass."]
    

    var randomQoute: Qoute {
        let item = qoutes.randomElement()
        let author = item!.key
        let qoute = item!.value
        
        return Qoute(author: author, qoute: qoute)
    }
}



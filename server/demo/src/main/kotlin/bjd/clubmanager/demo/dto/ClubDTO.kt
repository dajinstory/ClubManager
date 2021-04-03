package bjd.clubmanager.demo.dto

import bjd.clubmanager.demo.model.Club
import org.springframework.beans.factory.annotation.Autowired

data class ClubDTO @Autowired constructor(
    val id: Long? = null,
    val name: String,
    val president: Long
) {
    fun toEntity(): Club {
        return Club(
            name = name,
            president = president
        )
    }
}

data class ClubIdDTO @Autowired constructor(
    val clubId: Long
){
    fun toEntity(): Long {
        return clubId
    }
}

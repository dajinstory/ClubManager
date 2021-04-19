package bjd.clubmanager.demo.dto

import bjd.clubmanager.demo.model.Club
import org.springframework.beans.factory.annotation.Autowired

data class ClubDTO @Autowired constructor(
    val id: Long? = null,
    val name: String,
    val president: Long,
    val clubSummary: String,
    val category: String
) {
    fun toEntity(): Club {
        return Club(
            name = name,
            president = president,
            clubSummary = clubSummary,
            category = category
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

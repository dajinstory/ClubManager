package bjd.clubmanager.demo.dto

import bjd.clubmanager.demo.model.User
import org.springframework.beans.factory.annotation.Autowired

data class UserDTO @Autowired constructor(
    val id: Long? = null,
    val name: String,
    val clubs: String
) {
    fun toEntity(): User {
        return User(
            name = name,
            clubs = clubs
        )
    }
}

data class UserIdDTO @Autowired constructor(
    val id: Long
) {
    fun toEntity(): Long {
        return id
    }
}

data class UserClubsDTO @Autowired constructor(
    val clubs: String
) {
    fun toEntity(): String {
        return clubs
    }
}
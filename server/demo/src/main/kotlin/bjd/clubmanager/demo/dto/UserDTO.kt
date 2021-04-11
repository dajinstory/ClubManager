package bjd.clubmanager.demo.dto

import bjd.clubmanager.demo.model.User
import org.springframework.beans.factory.annotation.Autowired

data class UserDTO @Autowired constructor(
    val id: Long? = null,
    val email: String,
    val name: String,
    val clubs: String
) {
    fun toEntity(): User {
        return User(
            name = name,
            email = email,
            clubs = clubs
        )
    }
}

data class UserKeyDTO @Autowired constructor(
    val id: Long,
    val email: String
) {
    fun toIdEntity(): Long {
        return id
    }
    fun toEmailEntity(): String {
        return email
    }
}

data class UserClubsDTO @Autowired constructor(
    val clubs: String
) {
    fun toEntity(): String {
        return clubs
    }
}
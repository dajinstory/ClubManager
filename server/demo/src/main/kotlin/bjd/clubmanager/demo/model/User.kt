package bjd.clubmanager.demo.model

import bjd.clubmanager.demo.dto.UserDTO
//import com.opencsv.bean.CsvBindByName
import javax.persistence.*

@Entity
data class User (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    //@CsvBindByName(column = "id")
    val id: Long? = null,
    //@CsvBindByName(column = "email")
    val email: String,
    //@CsvBindByName(column = "name")
    val name: String,
    //@CsvBindByName(column = "clubs")
    val clubs: String
) {
    fun toDTO() : UserDTO {
        return UserDTO(
            id = id,
            email = email,
            name = name,
            clubs = clubs
        )
    }
}

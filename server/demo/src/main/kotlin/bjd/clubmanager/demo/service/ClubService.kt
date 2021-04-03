package bjd.clubmanager.demo.service

import bjd.clubmanager.demo.dto.ClubDTO
import bjd.clubmanager.demo.dto.UserClubsDTO
import bjd.clubmanager.demo.dto.UserDTO
import bjd.clubmanager.demo.repository.ClubRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
class ClubService {
    @Autowired
    lateinit var clubRepository: ClubRepository

    fun getClubs(): List<ClubDTO> {
        val clubs = clubRepository.findAll()
        return clubs.map { it.toDTO() }
    }

    fun getClubsById(userClubsDTO: UserClubsDTO): List<ClubDTO> {
        val clubIds:List<Long> = userClubsDTO.toEntity().split(",").map { it.toLong() }
        val clubDTOs:List<ClubDTO> = List(clubIds.size, {it -> clubRepository.findById(clubIds[it]).get().toDTO()})
        return clubDTOs
    }

    @Transactional
    fun createClub(clubDTO: ClubDTO) : ClubDTO {
        val club = clubRepository.save(clubDTO.toEntity())
        return club.toDTO()
    }
}
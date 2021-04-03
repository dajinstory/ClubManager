package bjd.clubmanager.demo.service

import bjd.clubmanager.demo.dto.ClubDTO
import bjd.clubmanager.demo.dto.MemberDTO
import bjd.clubmanager.demo.repository.MemberRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
class MemberService {
    @Autowired
    lateinit var memberRepository: MemberRepository

    fun getMembersByClubId(clubDTO: ClubDTO): List<MemberDTO> {
        val clubId = clubDTO.toEntity().id
        val users = memberRepository.findAllByClubIdEquals(clubId!!)
        return users.map{it.toDTO()}
    }

    @Transactional
    fun createMember(memberDTO: MemberDTO) : MemberDTO {
        val member = memberRepository.save(memberDTO.toEntity())
        return member.toDTO()
    }
}
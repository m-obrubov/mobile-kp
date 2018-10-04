package ru.obrubov.questionnaire.data.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import ru.obrubov.questionnaire.domain.Test;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

@Repository
public class TestRepositoryCustomImpl implements TestRepositoryCustom {

    private final EntityManager em;

    @Autowired
    public TestRepositoryCustomImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public Test getOne() {
        CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
        CriteriaQuery<Test> query = criteriaBuilder.createQuery(Test.class);
        Root<Test> from = query.from(Test.class);
        query
                .select(from)
                .orderBy(criteriaBuilder.desc(from.get("id")));
        List<Test> resultList = em.createQuery(query)
                .setFirstResult(0)
                .setMaxResults(1)
                .getResultList();
        return resultList.isEmpty() ? null : resultList.get(0);
    }
}

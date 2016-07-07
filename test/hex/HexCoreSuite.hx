package hex;

import hex.di.CoreDiSuite;
import hex.collection.CoreCollectionSuite;
import hex.core.CoreCoreSuite;
import hex.domain.CoreDomainSuite;
import hex.event.CoreEventSuite;
import hex.structures.CoreStructuresSuite;
import hex.util.CoreUtilSuite;

/**
 * ...
 * @author Francis Bourre
 */
class HexCoreSuite
{
    @Suite( "HexCore" )
    public var list : Array<Class<Dynamic>> = [ CoreCollectionSuite, CoreCoreSuite, CoreDiSuite, CoreDomainSuite, CoreEventSuite, CoreStructuresSuite, CoreUtilSuite ];
}
